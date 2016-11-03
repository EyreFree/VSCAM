

import UIKit

extension String {

    func count() -> Int {
        return self.characters.count
    }

    //MD5
    func MD5(length: Int32 = CC_MD5_DIGEST_LENGTH) -> String? {
        if let str = self.cString(using: String.Encoding.utf8) {
            let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
            let digestLen = Int(length)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_MD5(str, strLen, result)
            let hash = NSMutableString()
            for i in 0 ..< digestLen {
                hash.appendFormat("%02x", result[i])
            }
            result.deallocate(capacity: digestLen)
            return String(hash)
        }
        return nil
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

    //替换前缀
    func replacePrefix(string: String, with: String) -> String {
        if self.hasPrefix(string) {
            return with + String(self.characters.dropFirst(string.count()))
        }
        return self
    }

    //替换尾缀
    func replaceSuffix(string: String, with: String) -> String {
        if self.hasSuffix(string) {
            return String(self.characters.dropLast(string.count())) + with
        }
        return self
    }

    //移除某个子串
    func remove(string: String) -> String {
        return self.replace(string: string, with: "")
    }

    //移除某个前缀
    func removePrefix(string: String) -> String {
        return self.replacePrefix(string: string, with: "")
    }

    //移除某个尾缀
    func removeSuffix(string: String) -> String {
        return self.replaceSuffix(string: string, with: "")
    }

    //去除左右空格和换行
    func clean() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
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

    static func isEmpty(string: String?) -> Bool {
        if let tryString = string {
            return tryString == ""
        }
        return true
    }
}

