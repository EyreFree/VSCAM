

import Foundation
import UIKit

extension UIColor {

    //用十六进制数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    //黑色初始化
    convenience init(black: CGFloat, alpha: CGFloat) {
        let value = CGFloat(255 * (1 - black))
        self.init(red: value, green: value, blue: value, alpha: alpha)
    }

    //获取两个 UIColor 均值（只支持 RGB 空间颜色）
    func avarageWith(color: UIColor, alpha: CGFloat = 1.0) -> UIColor? {
        if let rgbArr1 = self.cgColor.components, let rgbArr2 = color.cgColor.components {
            return UIColor(
                red: (rgbArr1[0] + rgbArr2[0]) / 2,
                green: (rgbArr1[1] + rgbArr2[1]) / 2,
                blue: (rgbArr1[2] + rgbArr2[2]) / 2,
                alpha: alpha
            )
        }
        return nil
    }
}

