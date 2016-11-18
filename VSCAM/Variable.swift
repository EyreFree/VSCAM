

import UIKit

class Variable {

    //版本信息
    static var versionLocal: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    //登录信息
    static var loginUserInfo: UserInfoObject? {
        get {
            if loginMark == true {
                let uid = UserDefaults.standard.integer(forKey: "loginUserInfo_uid")
                let name = UserDefaults.standard.string(forKey: "loginUserInfo_name")
                let avatar = UserDefaults.standard.integer(forKey: "loginUserInfo_avatar")
                let des = UserDefaults.standard.string(forKey: "loginUserInfo_des")
                let url = UserDefaults.standard.string(forKey: "loginUserInfo_url")
                return UserInfoObject(uid: uid, name: name, avatar: avatar, des: des, url: url)
            }
            return nil
        }
        set {
            if nil == loginUserInfo {
                loginMark = false
            }
            UserDefaults.standard.set(newValue?.uid, forKey: "loginUserInfo_uid")
            UserDefaults.standard.set(newValue?.name, forKey: "loginUserInfo_name")
            UserDefaults.standard.set(newValue?.avatar, forKey: "loginUserInfo_avatar")
            UserDefaults.standard.set(newValue?.des, forKey: "loginUserInfo_des")
            UserDefaults.standard.set(newValue?.url, forKey: "loginUserInfo_url")
        }
    }
    static var loginMark = false
    static var loginNeedRefreshMain = true
}
