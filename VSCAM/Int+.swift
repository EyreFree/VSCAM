

import UIKit

extension Int {

    //计算位数
    func count() -> Int {
        return String(self).characters.count
    }

    //转 CGFloat
    func f() -> CGFloat {
        return CGFloat(self)
    }

    //
    static func fromJson(dict: AnyObject?) -> Int? {
        if let tryInt = dict as? Int {
            return tryInt
        } else if let tryString = dict as? String {
            if let tryInt = Int(tryString) {
                return tryInt
            }
        }
        return nil
    }
}

extension Int64 {

    //计算位数
    func count() -> Int {
        return String(self).characters.count
    }

    //转 CGFloat
    func f() -> CGFloat {
        return CGFloat(self)
    }

    //
    static func fromJson(dict: AnyObject?) -> Int64? {
        if let tryInt = dict as? Double {
            return Int64(tryInt)
        } else if let tryString = dict as? String {
            if let tryInt = Int64(tryString) {
                return tryInt
            }
        }
        return nil
    }
}

