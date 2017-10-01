
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
}
