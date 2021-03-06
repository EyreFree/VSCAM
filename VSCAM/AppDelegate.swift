//
//  AppDelegate.swift
//  VSCAM
//
//  Created by EyreFreeWork on 16/10/9.
//  Copyright © 2016年 EyreFree. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {

        setVersion()
        loadStory()

        setGlobalStyle()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //添加模糊效果，进入后台
        let view = SecurityStrategy(frame: self.window?.frame ?? UIScreen.main.bounds)
        view.tag = Tag.make(10086)
        for window in UIApplication.shared.windows {
            if window.windowLevel == UIWindow.Level.normal {
                window.addSubview(view)
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //移除模糊效果，进入前台
        for window in UIApplication.shared.windows {
            if window.windowLevel == UIWindow.Level.normal {
                let view = window.viewWithTag(Tag.make(10086))
                view?.removeFromSuperview()
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    //从 3D-Touch 启动
    func application(
        _ application: UIApplication,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
        ) {
        //判断标题
        if shortcutItem.localizedTitle == "打开分享链接" {
            let url = UIPasteboard.general.string ?? ""
            if url.count() > 0 {
                //打开外部分享链接
                if Function.openInUrl(url: url) == false {
                    Function.MessageBox(
                        MainNavigationController.sharedInstance,
                        title: String.Localized("提示"),
                        content: String.Localized("剪贴板内容无法识别")
                    )
                }
            } else {
                Function.MessageBox(
                    MainNavigationController.sharedInstance,
                    title: String.Localized("提示"),
                    content: String.Localized("剪贴板没有内容")
                )
            }
        }
        completionHandler(true)
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
        return Function.openOutUrl(url: url.absoluteString)
    }

    //自定义
    func setVersion() {
        //更新
        let verOut = UserDefaults.standard.string(forKey: "VSCAM_SAVE_VERSION")

        let dict = Bundle.main.infoDictionary
        if let newver = dict?["CFBundleVersion"] as? String {
            if let ver = verOut {
                let result = newver.compare(ver, options: .numeric)
                if result == .orderedDescending {
                    UserDefaults.standard.set(
                        false, forKey: "VSCAM_FIRST_RUN"
                    )
                }
            }
            UserDefaults.standard.set(
                newver, forKey: "VSCAM_SAVE_VERSION"
            )
        }
    }

    func loadStory() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetController = storyboard.instantiateInitialViewController()
        if let navi = targetController as? UINavigationController {
            if false == UserDefaults.standard.bool(forKey: "VSCAM_FIRST_RUN") {
                let open = EFOpenController()
                open.nextView = navi.topViewController!.view
                open.nextCtrl = navi
                window?.rootViewController = open
            } else {
                window?.rootViewController = navi
            }
        }
        window?.makeKeyAndVisible()
    }

    //设置一些全局样式
    func setGlobalStyle() {
        // 全局的各种颜色
        self.window?.tintColor = UIColor.black
        //设置状态栏字体颜色
        /*UIApplication.shared.setStatusBarStyle(
            UIStatusBarStyle.default, animated: false
        )*/
    }
}
