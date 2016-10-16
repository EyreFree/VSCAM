

import UIKit

extension NSURL {

    convenience init?(myString: String?) {
        if let tryString = myString {
            if nil != NSURL(string: tryString) {
                self.init(string: tryString)
            } else {
                if let encodeString = tryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    self.init(string: encodeString)
                } else {
                    return nil
                }
            }
        } else {
            return nil
        }
    }
}

