//
//  UserServices.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit
import Foundation
import RxSwift
import SwiftyJSON

class UserServices {
    /* example code
    static func signInUser(email: String,
                           password: String) -> Single<UserModel> {
        let params = ["email": email,
                      "pass": password]
        let jsonObservable = Network.shared.post(url: K.API.LoginPath, params: params)
        return jsonObservable.asObservable().flatMap ({ dictionary in
            Observable.create({ operation in
                //Parse user model
                if let status = dictionary["status"].int, status == 1 {
                    let data = dictionary["data"]
                    if let token = data["token"].string {
                        Helper.saveLocal(value: token, key: K.UserDefaults.Token)
                    }
                    
                    let user = UserModel(fromJson: data["user"])
                    user.save()
                    operation.onNext(user)
                    operation.onCompleted()
                } else {
                    let message = dictionary["message"].string ?? "Something went wrong"
                    let error = message.toNSError()
                    operation.onError(error)
                }
                
                return Disposables.create()
            }).asSingle()
        }).asSingle()
    }*/
}
