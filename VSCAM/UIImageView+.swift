

import UIKit
import SDWebImage

extension UIImageView {

    //设置图片
    func setImageWithURLString(UrlString: String?, placeholder: UIImage! = nil, animated: Bool = true, finish: @escaping (UIImage?) -> Void = { (image) in }) {
        //判空
        if let tryUrlString = UrlString {
            let imageUrl = NSURL(myString: tryUrlString)
            if !tryUrlString.isEmpty {
                if let tryImageUrl = imageUrl {
                    setImageWithURL(Url: tryImageUrl, placeholder: placeholder, animated: animated, finish: finish)
                    return
                }
            }
        }
        self.image = placeholder ?? UIImage.placeholderTransparent
        finish(self.image)
    }

    func setImageWithURL(Url: NSURL, placeholder: UIImage! = nil, animated: Bool = true, finish: @escaping (UIImage?) -> Void = { (image) in }) {
        let holderImage = placeholder ?? UIImage.placeholderTransparent

        //如果是头像则强制刷新
        var options = SDWebImageOptions.retryFailed
        /*if let tryUrl = Url.absoluteString {
            if true == tryUrl.hasSubString(string: NetworkURL.avatarIgnore) {
                options = [.retryFailed, .cacheMemoryOnly]
            }
        }*/

        //加载图片
        self.sd_setImage(with: Url as URL!, placeholderImage: holderImage, options: options) {
            [weak self] (image, error, cacheType, imageUrl) in
            if let strongSelf = self {
                if nil != image && cacheType == .none && animated {
                    UIView.transition(
                        with: strongSelf, duration: 0.35,
                        options: .transitionCrossDissolve,
                        animations: {
                            strongSelf.image = image
                    }, completion: nil)
                }
                finish(image)
            }
        }
    }
}

