//
//  Network.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire
import SwiftyJSON

struct Endpoint {
    static var APIEndPoint: String {
        return "baseUrl"
//        return AppDataSingleton.shared.baseUrl + "/v1"
    }
}

class Network {

    var defaultHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
//        if let accessToken = Helper.getAccessToken() {
//            headers.add(HTTPHeader(name: "Authorization", value: accessToken))
//        }
//        if let bundleID = Bundle.main.bundleIdentifier {
//            headers.add(HTTPHeader(name: "p", value: bundleID))
//        }
//        headers.add(HTTPHeader(name: "o", value: UIDevice.current.systemVersion))
//        if let time = Helper.getLocalValue(withKey: K.UserDefaults.InstallAppTime) as? Int {
//            headers.add(HTTPHeader(name: "t", value: "\(time)"))
//        }
//        if let isActive = Helper.getLocalValue(withKey: K.UserDefaults.IsActivedPlayerConfig) as? Int {
//            headers.add(HTTPHeader(name: "ia", value: "\(isActive)"))
//        }
        headers.add(HTTPHeader(name: "platform", value: "ios"))
        return headers
    }

    var youtubeHeaders: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(HTTPHeader(name: "x-youtube-client-name", value: "1"))
        headers.add(HTTPHeader(name: "x-youtube-client-version", value: "2.20210622.10.00"))
        return headers
    }

    static let shared = Network()

    func get(url: String, params: [String: Any]?, headers: HTTPHeaders? = nil) -> Single<JSON> {
        return request(method: .get, url: url, params: params, headers: headers)
    }

    func post(url: String, params: [String: Any]?, headers: HTTPHeaders? = nil) -> Single<JSON> {
        return request(method: .post, url: url, params: params, headers: headers)
    }

    func request(method: Alamofire.HTTPMethod, url: String, params: [String: Any]?, headers: HTTPHeaders? = nil) -> Single<JSON> {
        print(url)
        return Observable.create({ operation in
            if !Reachability.isConnectedToNetwork() {
                let message = "No Internet Connection"
                operation.onError(message.toNSError())
                return Disposables.create()

            }
            print("DEBUG: \(url)")
            do {
                let convertedURL = try url.asURL()
                let nextHandler: (HTTPURLResponse, Any) -> Void = { _, data in
                    do {
                        let rawData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let json = JSON(rawData)
                        if let status = json["status"].int, status == 3 {
                            NotificationCenter.default.post(name: NSNotification.Name("ShowMaintenanceIfNeed"), object: nil)
                            return
                        }

                        operation.onNext(JSON(rawData))
                        operation.onCompleted()
                    } catch {
                        if !Reachability.isConnectedToNetwork() {
                            let message = "No Internet Connection"
                            operation.onError(message.toNSError())
                        } else {
                            let error = "Something went wrong!".toNSError()
                            operation.onError(error)
                        }

                    }
                }

                let errorHandler: (Error) -> Void = { error in
                    if !Reachability.isConnectedToNetwork() {
                        let message = "No Internet Connection"
                        operation.onError(message.toNSError())
                    } else {
                        operation.onError(error)
                    }

                }

                let headers = headers != nil ? headers : Network.shared.defaultHeaders
                _ = RxAlamofire.requestJSON(method,
                                            convertedURL,
                                            parameters: params,
                                            encoding: JSONEncoding.default,
                                            headers: headers).subscribe(onNext: nextHandler, onError: errorHandler)
            } catch {
                let error = NSError(domain: "failed convert url",
                                    code: 0,
                                    userInfo: nil)
                operation.onError(error)
            }

            return Disposables.create()
        }).asSingle()
    }
}
enum ErrorHandle: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

public typealias ResultHandler<Success> = (_ result: Result<Success, Error>) -> Void
