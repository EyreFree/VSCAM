

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
    static let avatarSmall = "https://vscam.co/avatar/s/{avatar}.jpg"
    static let avatarBig = "https://vscam.co/avatar/b/{avatar}.jpg"
    //个人页面地址
    static let userDetailPage = "https://vscam.co/#!u/{name}"
    //登录 POST id:qwe@vscam.co password:wsph123
    static let login = "http://vscam.co/x/?a=u"
    //注册 POST name:qwe mail:qwe@vscam.co password:wsph123
    static let registe = "http://vscam.co/x/?a=u"

    //MARK:- 其他
    //AppStore
    static let appStore = "https://itunes.apple.com/cn/app/VSCAM/id1163589746?mt=8"
}

