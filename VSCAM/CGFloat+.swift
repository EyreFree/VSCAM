

import UIKit

extension CGFloat {

    //MARK:- 高度
    //状态栏高:20
    static func statusBar() -> CGFloat {
        NSLog("statusBar: \(UIApplication.shared.statusBarFrame.height)")
        return UIApplication.shared.statusBarFrame.height
    }
    //导航栏高:44
    static func navigationBar(controller: UIViewController?) -> CGFloat {
        if let navi = controller?.navigationController {
            NSLog("navigationBar: \(navi.navigationBar.frame.height)")
            return navi.navigationBar.frame.height
        }
        NSLog("navigationBar: 0")
        return 0
    }
    //tabBar高:49
    static func tabBar(controller: UIViewController?) -> CGFloat {
        if let tabBar = controller?.tabBarController {
            NSLog("tabBar: \(tabBar.tabBar.frame.height)")
            return tabBar.tabBar.frame.height
        }
        NSLog("tabBar: 0")
        return 0
    }
}

