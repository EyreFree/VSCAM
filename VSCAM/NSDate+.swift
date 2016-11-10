

import UIKit

extension Date {

    //MARK:- 格式转换
    func toString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }

    //时间戳转日期
    static func fromJson(timestamp: AnyObject?) -> Date? {
        if let tryTimestamp = Int64.fromJson(timestamp) {
            return Date(timeIntervalSince1970: Double(tryTimestamp))
        }
        return nil
    }

    static func fromValue(value: Int64) -> Date {
        return Date(timeIntervalSince1970: Double(value))
    }
}

