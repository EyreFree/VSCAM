

import Foundation

class PublishModel {

    var image: UIImage?

    func headImageHeight() -> CGFloat {
        var scale = 1.f()
        if let tryScale = image?.aspectRatio() {
            scale = tryScale
        }
        return scale * UIScreen.main.bounds.size.width
    }
}
