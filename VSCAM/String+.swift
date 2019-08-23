
import UIKit

extension String {

    func count() -> Int {
        return self.count
    }

    //正则表达式
    func conform(regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }

    //检测是否存在某子字符串(无视大小写)
    func hasSubString(string: String) -> Bool {
        return nil != self.range(of: string, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
    }

    //替换某个子字符串为另一字符串
    func replace(string: String, with: String) -> String {
        return self.replacingOccurrences(of: string, with: with, options: String.CompareOptions.literal, range: nil)
    }

    //移除某个子串
    func remove(string: String) -> String {
        return self.replace(string: string, with: "")
    }

    //转为dictionary
    func toDictionary() -> Any? {
        if let tryData = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(
                    with: tryData, options: JSONSerialization.ReadingOptions.allowFragments
                )
            } catch {
                print("toDictionary Error!")
            }
        }
        return nil
    }

    //国际化
    static func Localized(_ key: String) -> String {
        return key.i18n()
    }
}
