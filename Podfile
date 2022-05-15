# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def main_pods
  use_frameworks!
  inhibit_all_warnings!
  pod 'SwiftyJSON'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxAlamofire'
  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :branch => 'version6-xcode13'
  pod 'SwiftGen'
  pod 'SnapKit'
  pod 'SVProgressHUD'
  pod 'ReachabilitySwift'
  pod 'Toaster'
  pod 'SwiftLint'
end

target 'BaseProject' do
  main_pods
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.1'
        config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
end
