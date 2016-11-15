

import UIKit

class Variable {

    //版本信息
    static var versionLocal: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    //登录信息
    static var user: UserInfoObject?
}
