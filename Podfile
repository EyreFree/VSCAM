source 'https://github.com/CocoaPods/Specs.git'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

inhibit_all_warnings!
platform :ios, '10.0'
use_frameworks!

target 'VSCAM' do
  pod 'Alamofire'
  pod 'BaiduMobStatCodeless'
  pod 'EFNavigationBar', '>= 5.1.4'
  pod 'JGProgressHUD'
  pod 'KMPlaceholderTextView'
  pod 'Kingfisher'
  pod 'LFRoundProgressView'
  pod 'MJRefresh'
  pod 'NJKWebViewProgress'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'R.swift'
  pod 'SwiftMessages'
  pod 'SDWebImage'
  pod 'SVProgressHUD'
  pod 'SnapKit'
  pod 'YLGIFImage'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
