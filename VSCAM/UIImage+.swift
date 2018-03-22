
import UIKit

extension UIImage {

    static let placeholder = R.image.placeholder_default()
    static let placeholderUser = R.image.placeholder_user()
    static let placeholderTransparent = R.image.placeholder_transparent()

    //绘制渐变图片
    static func gradient(colorBegin: UIColor, colorEnd: UIColor, size: CGSize, isTilt: Bool = false) -> UIImage? {
        //获取rgb
        if let componentsBegin = colorBegin.cgColor.components, let componentsEnd = colorEnd.cgColor.components {
            //创建渐变规则
            let colors = [
                componentsBegin[0], componentsBegin[1], componentsBegin[2], 1.00,
                componentsEnd[0], componentsEnd[1], componentsEnd[2], 1.00
            ]

            if let tryGradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colors, locations: nil, count: 2) {
                //画图
                UIGraphicsBeginImageContext(size)
                UIGraphicsGetCurrentContext()?.drawLinearGradient(
                    tryGradient,
                    start: CGPoint(x: 0, y: 0),
                    end: CGPoint(x: isTilt ? size.width : 0, y: size.height),
                    options: CGGradientDrawingOptions(rawValue: 1)
                )
                let rtImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                return rtImage
            }
        }
        return nil
    }

    //获取平均颜色
    func avarageColor() -> UIColor {
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        if let context = CGContext(
            data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) {
            if let tryCGImage = self.cgImage {
                context.draw(tryCGImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
            }
        }

        if rgba[3] > 0 {
            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
            let multiplier: CGFloat = alpha / 255.0

            return UIColor(
                red: CGFloat(rgba[0]) * multiplier,
                green: CGFloat(rgba[1]) * multiplier,
                blue: CGFloat(rgba[2]) * multiplier,
                alpha: alpha
            )
        } else {
            return UIColor(
                red: CGFloat(rgba[0]) / 255.0,
                green: CGFloat(rgba[1]) / 255.0,
                blue: CGFloat(rgba[2]) / 255.0,
                alpha: CGFloat(rgba[3]) / 255.0
            )
        }
    }

    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    //绘制纯色图片
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let tryCGImage = newImage?.cgImage {
            self.init(cgImage: tryCGImage)
        } else {
            return nil
        }
    }

    //.9
    func nine(insets: UIEdgeInsets? = nil) -> UIImage {
        var finalInsets: UIEdgeInsets!
        if let tryInsets = insets {
            finalInsets = tryInsets
        } else {
            let width = self.size.width
            let height = self.size.height
            if width > 3 && height > 3 {
                let hMargin = (width - 1) / 2
                let vMargin = (height - 1) / 2
                finalInsets = UIEdgeInsets(top: vMargin, left: hMargin, bottom: vMargin, right: hMargin)
            }
        }
        if let tryFinalInsets = finalInsets {
            return self.resizableImage(withCapInsets: tryFinalInsets, resizingMode: .stretch)
        }
        return self
    }

    //宽高比
    func aspectRatio() -> CGFloat {
        return self.size.height / self.size.width
    }
}
