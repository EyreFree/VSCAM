

import UIKit
import SwiftMessages
import SVProgressHUD

enum MessageBoxType {
    case error
    case info
    case success
}

class Function: NSObject {

    //简单的模态消息弹窗
    static func MessageBox(_ controller: UIViewController, title: String?, content: String?, buttonTitle: String = "确定",
                           type: MessageBoxType = .error, finish: ((UIAlertAction) -> Void)? = nil) {
        if nil != finish {
            let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: finish))
            controller.present(alert, animated: true, completion: nil)
        } else {
            switch type {
            case .error:
                SVProgressHUD.showError(withStatus: content)
                break
            case .info:
                SVProgressHUD.showInfo(withStatus: content)
                break
            case .success:
                SVProgressHUD.showSuccess(withStatus: content)
                break
            }
        }
    }

    //收起键盘
    static func HideKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    static func setStatusBar(hidden: Bool) {
        UIApplication.shared.isStatusBarHidden = hidden
    }

    //打开外部链接对应的页面
    static func openOutUrl(url: String) -> Bool {
        let preUrl = url.removePrefix(string: "http://").removePrefix(string: "https://")

        //如果是图片详情页
        let imagePagePrefix = NetworkURL.imageDetailPage.removeSuffix(string: "{pid}")
            .removePrefix(string: "http://").removePrefix(string: "https://")
        if preUrl.hasPrefix(imagePagePrefix) {
            let imageID = preUrl.removePrefix(string: imagePagePrefix)
            if let tryID = Int(imageID), imageID.count() > 0 {
                print(tryID)
/*
                NetworkAPI.sharedInstance.imageDetail(id: tryID) {
                    (data, errorString) in
                        if let tryErrorString = errorString {
                            Function.MessageBox(<#T##controller: UIViewController##UIViewController#>, title: <#T##String?#>, content: <#T##String?#>)

                            Function.MessageBox(trySelf, title: "图片举报失败", content: tryErrorString)
                            LoadingView.sharedInstance.hide()
                        } else {
                            //主页刷新
                            Variable.listNeedRefreshMain = true
                            //用户页刷新
                            for controller in MainNavigationController.sharedInstance.viewControllers {
                                if let tryController = controller as? UserDetailController {
                                    tryController.model.needRefreshList = true
                                }
                            }
                            LoadingView.sharedInstance.hide()
                            Function.MessageBox(
                                trySelf, title: "提示",
                                content: "图片举报成功，感谢您的反馈！您将不会在列表中再次看到该图片，我们将会尽快对您的举报信息进行核实与处理，您将在 24 小时内收到我们的反馈邮件。"
                            ) {
                                [weak self] (action) in
                                if let _ = self {
                                    MainNavigationController.sharedInstance.popViewController(animated: true)
                                }
                            }
                        }
                }
*/
                return true
            }
        }
        //如果是用户详情页
        let userPagePrefix = NetworkURL.userDetailPage.removeSuffix(string: "{name}")
            .removePrefix(string: "http://").removePrefix(string: "https://")
        if preUrl.hasPrefix(userPagePrefix) {
            let userID = preUrl.removePrefix(string: userPagePrefix)
            if userID.count() > 0 {
                print(userID)
                return true
            }
            return true
        }
        return false
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
}
