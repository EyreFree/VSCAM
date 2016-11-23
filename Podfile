

platform :ios, '9.0'
use_frameworks!

target 'VSCAM' do
    pod 'SnapKit', '~> 3.0.1'                   # 约束
    pod 'Alamofire', '~> 4.0.1'                 # 网络
    pod 'SDWebImage', '~> 3.7.6'                # 图片加载
    pod 'JGProgressHUD', '~> 1.3.2'             # Loading
    pod 'MJRefresh', '~> 3.1.0'                 # 上拉/下拉刷新
    pod 'NJKWebViewProgress', '~> 0.2.3'        # WebView 进度条
    pod 'UMengAnalytics-NO-IDFA', '~> 4.1.1'    # UMeng 统计分析
    pod 'KMPlaceholderTextView', '~> 1.3.0'     # 带占位文字的多行编辑框
    pod 'SwiftMessages', '~> 3.0.3'             # 消息框
    pod 'LFRoundProgressView', '~> 1.0.0'       # 进度条
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

