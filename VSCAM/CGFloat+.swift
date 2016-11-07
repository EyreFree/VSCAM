

import UIKit

extension CGFloat {

    //为某些不能为 0 的地方定的一个极小值
    static let zeroHeight = CGFloat(0.00000000000000000001)

    //MARK:- 高度
    //状态栏高:20
    static func statusBar() -> CGFloat {
        NSLog("statusBar: \(UIApplication.shared.statusBarFrame.height)")
        return UIApplication.shared.statusBarFrame.height
    }
    //导航栏高:44
    static func navigationBar(_ controller: UIViewController?) -> CGFloat {
        if let navi = controller?.navigationController {
            NSLog("navigationBar: \(navi.navigationBar.frame.height)")
            return navi.navigationBar.frame.height
        }
        NSLog("navigationBar: 0")
        return 0
    }
    //tabBar高:49
    static func tabBar(_ controller: UIViewController?) -> CGFloat {
        if let tabBar = controller?.tabBarController {
            NSLog("tabBar: \(tabBar.tabBar.frame.height)")
            return tabBar.tabBar.frame.height
        }
        NSLog("tabBar: 0")
        return 0
    }
}

