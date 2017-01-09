//
//  AppDelegate.swift
//  VSCAM
//
//  Created by EyreFreeWork on 16/10/9.
//  Copyright © 2016年 EyreFree. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setFabricParam()
        setUMengParam()
        setGlobalStyle()

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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //从 3D-Touch 启动
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        //判断标题
        if shortcutItem.localizedTitle == "打开分享链接" {
            let url = UIPasteboard.general.string ?? ""
            if url.count() > 0 {
                //打开外部分享链接
                if Function.openInUrl(url: url) == false {
                    Function.MessageBox(MainNavigationController.sharedInstance, title: "提示", content: "剪贴板内容无法识别")
                }
            } else {
                Function.MessageBox(MainNavigationController.sharedInstance, title: "提示", content: "剪贴板没有内容")
            }
        }
        completionHandler(true)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return Function.openOutUrl(url: url.absoluteString)
    }

    //自定义
    //配置 Fabric
    func setFabricParam() {
        Fabric.with([Crashlytics.self])
    }

    //配置 UMeng 参数
    func setUMengParam() {
        let config = UMAnalyticsConfig()
        config.appKey = "57fe536267e58ee0e6003e6c"
        config.bCrashReportEnabled = true
        config.channelId = "App Store"
        config.ePolicy = BATCH
        MobClick.start(withConfigure: config)
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

