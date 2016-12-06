

import UIKit

//MARK:- 接口地址
class NetworkURL {

    //MARK:- 基地址
    static let baseUrl = "https://vscam.co/x/"

    //MARK:- 接口地址
    //图片列表 - 首页 or 用户页
    static let imageList = "?a=h"
    //图片详细页
    static let imageDetail = "?a=p"
    //获取个人信息
    static let userInfoList = "?a=u&uid="
    //登录
    static let login = "?a=u"
    //登出
    static let logout = "?a=logout&_r="
    //注册
    static let registe = "?a=u"
    //修改个人信息
    static let change = "?a=u"
    //删除头像
    static let avatarDelete = "?a=avatar.del"
    //设置头像
    static let avatarSet = "?a=avatar"
    //上传图片
    static let upload = "?a=upload"
    //删除图片post  remove pid=1
    static let delete = "?a=remove"
    //发布图片
    static let release = "?a=release"
    //举报图片
    static let report = "?a=filter"

    //预览图微博基地址
    static let imageWBSmall = "https://ws2.sinaimg.cn/bmiddle/"
    //完整图微博基地址
    static let imageWBBig = "https://ws2.sinaimg.cn/large/"
    //备份预览图
    static let imageOriginSmall = "https://vscam.co/img/s/{origin}.jpg"
    //备份完整图
    static let imageOriginBig = "https://vscam.co/img/m/{origin}.jpg"
    //地图图片
    static let imageMap = "https://vscam.co/x/maps/{gps}%7C11%7C800*300.png"
    //Web详情页地址
    static let imageDetailPage = "https://vscam.co/#!g/{pid}"
    //头像
    static let avatarIgnore = "https://vscam.co/avatar/"
    static let avatarSmall = "https://vscam.co/avatar/s/{avatar}.jpg"
    static let avatarBig = "https://vscam.co/avatar/b/{avatar}.jpg"
    //个人页面地址
    static let userDetailPage = "https://vscam.co/#!u/{name}"

    //MARK:- 其他
    //AppStore
    static let appStore = "https://itunes.apple.com/cn/app/VSCAM/id1163589746?mt=8"
    //隐私政策
    static let privacy = "http://vscam.co/privacy.html"
    //VSCAM
    static let vscam = "https://vscam.co"
}

