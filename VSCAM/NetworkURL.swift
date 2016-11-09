

import UIKit

//MARK:- 接口地址
class NetworkURL {

    //MARK:- 基地址
    static let baseUrl = "http://vscam.co/x/"

    //MARK:- 接口地址
    //图片列表 - 首页 or 用户页
    static let imageList = "?a=h"
    //图片详细页
    static let imageDetail = "?a=p"
    //预览图微博基地址
    static let imageWBSmall = "http://ww2.sinaimg.cn/bmiddle/"
    //完整图微博基地址
    static let imageWBBig = "http://ww2.sinaimg.cn/large/"
    //备份预览图
    static let imageOriginSmall = "http://vscam.co/img/s/{origin}.jpg"
    //备份完整图
    static let imageOriginBig = "http://vscam.co/img/m/{origin}.jpg"

    //MARK:- 其他
    //AppStore
    static let appStore = "https://itunes.apple.com/cn/app/VSCAM/id1163589746?mt=8"
}

