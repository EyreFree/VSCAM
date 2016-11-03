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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setGlobalStyle()
        showStatusBar()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //添加模糊效果，进入后台
        let view = SecurityStrategy(frame: self.window?.frame ?? UIScreen.main.bounds)
        view.tag = Tag.make(10086)
        for window in UIApplication.shared.windows {
            if window.windowLevel == UIWindowLevelNormal {
                window.addSubview(view)
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //移除模糊效果，进入前台
        for window in UIApplication.shared.windows {
            if window.windowLevel == UIWindowLevelNormal {
                let view = window.viewWithTag(Tag.make(10086))
                view?.removeFromSuperview()
            }
        }
        //显示状态栏
        showStatusBar()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //显示状态栏
        showStatusBar()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //自定义
    //在plist中关闭状态栏然后进app后打开可以做到loading全屏无状态栏
    func showStatusBar() {
        if UIApplication.shared.isStatusBarHidden {
            UIApplication.shared.isStatusBarHidden = false
        }
    }

    //设置一些全局样式
    func setGlobalStyle() {
        let mainColor = UIColor(valueRGB: 0xf8f8f8)
        let tintColor = UIColor.black
        // 全局的各种颜色
        if let targetWindow = self.window {
            targetWindow.tintColor = mainColor
        }
        // 导航栏
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.backgroundColor = UIColor.clear
        navigationBarProxy.barTintColor = mainColor     // 背景色
        navigationBarProxy.tintColor = tintColor       // 按钮、图标等颜色
        navigationBarProxy.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
        ]
        navigationBarProxy.barStyle = UIBarStyle.black
        //去除导航栏底边白线
        /*navigationBarProxy.setBackgroundImage(
         UIImage(color: UIColor.clearColor(), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 20)),
         forBarPosition: .Top, barMetrics: .Default
         )
         navigationBarProxy.shadowImage = UIImage()*/
        //设置状态栏字体颜色
        UIApplication.shared.setStatusBarStyle(
            UIStatusBarStyle.default, animated: false
        )
    }
}

