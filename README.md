![](https://raw.githubusercontent.com/EyreFree/VSCAM/master/assets/VSCAM.png)

<p align="center">
<a href="https://travis-ci.org/EyreFree/VSCAM"><img src="http://img.shields.io/travis/EyreFree/VSCAM.svg"></a>
<a href="https://codebeat.co/projects/github-com-eyrefree-vscam-master"><img alt="codebeat badge" src="https://codebeat.co/badges/042a96e8-e93a-4f98-bba7-da9c806647e9" /></a>
<a href="https://github.com/apple/swift"><img src="https://img.shields.io/badge/language-swift-orange.svg"></a>
<a href="https://twitter.com/EyreFree777"><img src="https://img.shields.io/badge/twitter-@EyreFree777-blue.svg?style=flat"></a>
<a href="http://weibo.com/eyrefree777"><img src="https://img.shields.io/badge/weibo-@EyreFree-red.svg?style=flat"></a>
<img src="https://img.shields.io/badge/made%20with-%3C3-orange.svg">
</p>

VSCAM 是一个图片分享发布装置，本仓库为 iOS 端源代码，使用 Swift 进行开发。

## 概述

- 首页使用 UICollectionView 实现不同尺寸图片的瀑布流展示；  
- 发布页使用 Alamofire 实现了图片后台上传并且实时显示上传进度；  
- 图片详情页使用 UITableView 实现了类似 QQ 个人信息页面的背景图片拉伸效果；  
- 利用 MJPhotoBrowser 实现图片浏览功能；  
- 登录与注册页使用 UITableView 实现了焦点所在编辑框自动滚动到屏幕中心的效果；  
- 使用 ShareExtension 利用系统分享实现从浏览器页面打开 App 对应页面；  
- 使用 3D Touch 实现从剪贴板读取 URL 快速打开 App 内指定页面；  
- 集成 UMeng 与 Fabric 统计分析 SDK，可作为新手参考。

## AppStore

<a target='_blank' href='https://itunes.apple.com/cn/app/VSCAM/id1163589746?mt=8'>
	<img src='http://ww2.sinaimg.cn/large/0060lm7Tgw1f1hgrs1ebwj308102q0sp.jpg' width='144' height='49'/>
</a>

## 环境

| Version | Needs                                |
|:--------|:-------------------------------------|
| 1.x     | XCode 8.0+<br>Swift 3.0+<br>iOS 9.0+ |
| 4.x     | XCode 9.0+<br>Swift 4.0+<br>iOS 9.0+ |

## 构建

0. 首先，需要安装 [CocoaPods](https://github.com/CocoaPods/CocoaPods) 如果你没有安装的话；
1. 在终端中移动到当前工程根目录下执行 `pod install`；
2. 用 XCode 打开 VSCAM.xcworkspace；
3. 构建。

## 计划

1. iPad 适配；
2. 动画；
3. 评论／点赞。

## 预览

![](assets/screenshot.png)

## 其他

Android 版源码参见：[https://github.com/ayaseruri/vscam](https://github.com/ayaseruri/vscam)

更多信息请访问官网：[http://vscam.co/](http://vscam.co/)

## 作者

- 设计：[itorr](https://github.com/itorr), itorrrrrr@me.com
- 施工：[EyreFree](https://github.com/EyreFree), eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

VSCAM 基于 MIT 协议进行分发和使用，更多信息参见协议文件。
