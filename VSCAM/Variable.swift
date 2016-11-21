

import UIKit

class Variable {

    //版本信息
    static var versionLocal: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    //当前登录者
    static var lastLoginUser: String? {
        get {
            return UserDefaults.standard.string(forKey: "loginUserInfo_lastLoginUser")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "loginUserInfo_lastLoginUser")
        }
    }

    static var lastLoginPWD: String? {
        get {
            return UserDefaults.standard.string(forKey: "loginUserInfo_lastLoginPWD")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "loginUserInfo_lastLoginPWD")
        }
    }

    //登录信息
    static var loginUserInfo: UserSelfInfoObject? {
        get {
            let uid = UserDefaults.standard.integer(forKey: "loginUserInfo_uid")
            let name = UserDefaults.standard.string(forKey: "loginUserInfo_name")
            let avatar = UserDefaults.standard.integer(forKey: "loginUserInfo_avatar")
            let des = UserDefaults.standard.string(forKey: "loginUserInfo_des")
            let url = UserDefaults.standard.string(forKey: "loginUserInfo_url")
            let group = UserDefaults.standard.integer(forKey: "loginUserInfo_group")
            let look = UserDefaults.standard.integer(forKey: "loginUserInfo_look")
            let like = UserDefaults.standard.integer(forKey: "loginUserInfo_like")
            return UserSelfInfoObject(
                uid: uid, name: name, avatar: avatar, des: des,
                url: url, group: group, look: look, like: like
            )
        }
        set {
            UserDefaults.standard.set(newValue?.uid, forKey: "loginUserInfo_uid")
            UserDefaults.standard.set(newValue?.name, forKey: "loginUserInfo_name")
            UserDefaults.standard.set(newValue?.avatar, forKey: "loginUserInfo_avatar")
            UserDefaults.standard.set(newValue?.des, forKey: "loginUserInfo_des")
            UserDefaults.standard.set(newValue?.url, forKey: "loginUserInfo_url")
            UserDefaults.standard.set(newValue?.group, forKey: "loginUserInfo_group")
            UserDefaults.standard.set(newValue?.look, forKey: "loginUserInfo_look")
            UserDefaults.standard.set(newValue?.like, forKey: "loginUserInfo_like")
        }
    }
    static func loginUserInfoSetDes(newValue: String) {
        UserDefaults.standard.set(newValue, forKey: "loginUserInfo_des")
    }
    static func loginUserInfoSetUrl(newValue: String) {
        UserDefaults.standard.set(newValue, forKey: "loginUserInfo_url")
    }
    static func loginUserInfoSetAvatar(newValue: Int) {
        UserDefaults.standard.set(newValue, forKey: "loginUserInfo_avatar")
    }
    static var loginNeedRefreshMain = true
}
