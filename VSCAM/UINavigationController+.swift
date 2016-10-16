

import UIKit

extension UINavigationController {

    //设置白色底色
    func addWhiteBackground(alpha: CGFloat = 0.99) {
        self.navigationBar.setBackgroundImage(
            UIImage(color: UIColor(white: 1, alpha: alpha), size: CGSize(width: CGSize.screen().width, height: 64)),
            for: .default
        )
        self.navigationBar.tintColor = UIColor.black
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black
        ]
    }

    //设置黑色底色
    func addBlackBackground(alpha: CGFloat = 0.99) {
        self.navigationBar.setBackgroundImage(
            UIImage(color: UIColor(black: 1, alpha: alpha), size: CGSize(width: CGSize.screen().width, height: 64)),
            for: .default
        )
        self.navigationBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
}

