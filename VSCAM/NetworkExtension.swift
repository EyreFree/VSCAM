
extension Double {

    static func fromJson(_ dict: Any?) -> Double? {
        if let tryDouble = dict as? Double {
            return tryDouble
        } else if let tryString = dict as? String {
            if let tryDouble = Double(tryString) {
                return tryDouble
            }
        }
        return nil
    }
}

extension Int {

    static func fromJson(_ dict: Any?) -> Int? {
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

    static func fromJson(_ dict: Any?) -> Int64? {
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

extension String {

    static func fromJson(_ dict: Any?) -> String? {
        if let tryString = dict as? String {
            return tryString
        }
        return nil
    }
}

extension NSData {

    //MARK:- 格式转换
    static func json2Data(_ dict: AnyObject?) -> Data? {
        if let tryDict = dict {
            do {
                return try JSONSerialization.data(
                    withJSONObject: tryDict, options: JSONSerialization.WritingOptions.prettyPrinted
                )
            } catch {
                NSLog("json2Data Error!")
            }
        }
        return nil
    }

    static func data2Json(_ data: Data?) -> Any? {
        if let tryData = data {
            do {
                return try JSONSerialization.jsonObject(
                    with: tryData as Data, options: JSONSerialization.ReadingOptions.allowFragments
                )
            } catch {
                NSLog("data2Json Error!")
            }
        }
        return nil
    }

    //Local Cache
    func localSave(name: String?) {
        if let tryName = name {
            UserDefaults.standard.set(self, forKey: tryName)
        }
    }

    static func localLoad(name: String?) -> NSData?  {
        if let tryName = name {
            return UserDefaults.standard.object(forKey: tryName) as? NSData
        }
        return nil
    }
}
