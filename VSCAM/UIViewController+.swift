

import UIKit

extension UIViewController {

    //查找顶层View
    func topView() -> UIView {
        var recentVC = self
        while let parentVC = recentVC.parent {
            recentVC = parentVC
        }
        return recentVC.view
    }

    //MARK:- 导航栏
    //设置导航栏标题
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }

    func setTabBarNavigationTitle(title: String) {
        self.parent?.navigationItem.title = title
    }

    //添加按钮:func naviButtonClick(button: UIBarButtonItem)
    func addNavigationButton(title: String) {
        let setButton = UIBarButtonItem(
            title: title, style: .plain,
            target: self, action: Selector(("naviButtonClick:"))
        )
        setButton.isEnabled = true
        self.navigationItem.rightBarButtonItem = setButton
    }

    func addNavigationButtonWithImageName(imageName: String, isRight: Bool = true) {
        let setButton = UIBarButtonItem(
            image: UIImage(named: imageName) ?? UIImage.placeholder, style: .plain, target: self,
            action: isRight ? Selector(("naviButtonClick:")) : Selector(("naviLeftButtonClick:"))
        )
        setButton.isEnabled = true
        if isRight {
            self.navigationItem.rightBarButtonItem = setButton
        } else {
            self.navigationItem.leftBarButtonItem = setButton
        }
    }

    //主要
    func addTabBarNavigationButton(title: String) {
        let setButton = UIBarButtonItem(
            title: title, style: .plain,
            target: self, action: Selector(("naviButtonClick:"))
        )
        setButton.isEnabled = true
        self.parent?.navigationItem.rightBarButtonItem = setButton
    }

    func addTabBarNavigationButtonWithImageName(imageName: String, isRight: Bool = true) {
        let setButton = UIBarButtonItem(
            image: UIImage(named: imageName) ?? UIImage.placeholder, style: .plain, target: self,
            action: isRight ? Selector(("naviButtonClick:")) : Selector(("naviLeftButtonClick:"))
        )
        setButton.isEnabled = true
        if isRight {
            self.parent?.navigationItem.rightBarButtonItem = setButton
        } else {
            self.parent?.navigationItem.leftBarButtonItem = setButton
        }
    }

    @objc func naviButtonClick(button: UIBarButtonItem) {
        //收起键盘
        Function.HideKeyboard()
    }

    @objc func naviLeftButtonClick(button: UIBarButtonItem) {
        //收起键盘
        Function.HideKeyboard()
    }
}

