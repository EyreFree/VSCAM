
import Foundation

class NetworkCache {

    static var cookies: [HTTPCookie]? {
        get {
            if let tryData = UserDefaults.standard.data(forKey: "VSCAM_cookies") {
                return NSKeyedUnarchiver.unarchiveObject(with: tryData) as? [HTTPCookie]
            }
            return nil
        }
        set {
            if let tryNewValue = newValue {
                UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: tryNewValue), forKey: "VSCAM_cookies")
            } else {
                UserDefaults.standard.removeObject(forKey: "VSCAM_cookies")
            }
        }
    }

    static func saveCookies() {
        NetworkCache.cookies = NetworkAPI.sharedInstance.manager.session.configuration.httpCookieStorage?.cookies
    }
}
