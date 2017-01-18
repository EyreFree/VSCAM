

import UIKit

class MainNavigationController: UINavigationController, UINavigationControllerDelegate {

    //这不是单例，但是目的类似的
    static var sharedInstance: MainNavigationController!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        MainNavigationController.sharedInstance = self

        self.delegate = self
    }
}
