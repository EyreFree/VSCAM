

import UIKit
import SwiftMessages
import SVProgressHUD

class Function: NSObject {

    //简单的模态消息弹窗
    static func MessageBox(_ controller: UIViewController, title: String?, content: String?, buttonTitle: String = "确定",
                           theme: Theme = .error, finish: ((UIAlertAction) -> Void)? = nil) {
        /*let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: finish))
         controller.present(alert, animated: true, completion: nil)*/

        // View setup
        /*let layout = MessageView.Layout.CardView
        let theme = theme
        let view = MessageView.viewFromNib(layout: layout)
        view.configureContent(title: title, body: content, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: buttonTitle) {
            (button) in
            SwiftMessages.hide()
        }
        view.configureTheme(theme, iconStyle: IconStyle.default)
        view.configureDropShadow()

        // Config setup
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        config.duration = .seconds(seconds: 3)
        config.shouldAutorotate = true
        config.interactiveHide = true

        // Set status bar style unless using card view (since it doesn't go behind the status bar).
        if case .top = config.presentationStyle, layout != .CardView {
            if theme != .info {
                config.preferredStatusBarStyle = .lightContent
            }
        }

        SwiftMessages.show(config: config, view: view)*/

        if theme == .success {
            SVProgressHUD.showSuccess(withStatus: content)
        } else {
            SVProgressHUD.showError(withStatus: content)
        }
    }

    //收起键盘
    static func HideKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    static func setStatusBar(hidden: Bool) {
        UIApplication.shared.isStatusBarHidden = hidden
    }

    //打开WebView
    static func openWebView(url: String?, navi: UINavigationController?) {
        /*if let tryURL = url, let tryNavi = navi {
         tryNavi.pushViewController(
         WebViewController(urlString: tryURL), animated: true
         )
         }*/
    }

    //登陆框
    static func openLoginRegisterView() {
        //LoginRegisterViewController.show(MainTabBarController.sharedInstance, toMe: true)
    }

    //打开分享对话框
    static func openShareView(controller: UIViewController, title: String, url: String) {
        if let tryUrl = NSURL(myString: url) {
            let shareVC = UIActivityViewController(activityItems: [title, tryUrl], applicationActivities: nil)

            //阻止 iPad Crash
            shareVC.popoverPresentationController?.sourceView = controller.view
            shareVC.popoverPresentationController?.sourceRect = CGRect(
                x: controller.view.bounds.size.width / 2.0,
                y: controller.view.bounds.size.height / 2.0,
                width: 1.0, height: 1.0
            )

            controller.present(shareVC, animated: true) {
                //分享完成回调
                print("分享内容[\(title)][\(url)]")
            }
        }
    }

    //打开 AppStore
    static func openAppStore() {
        if let tryUrl = URL(myString: NetworkURL.appStore) {
            UIApplication.shared.openURL(tryUrl)
        }
    }
}
