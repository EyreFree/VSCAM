
import Foundation

class ImageDetailModel {

    var imageBrief: PhotoObject?

    var imageDetail: PhotoDetailObject?

    var image: UIImage?

    func headImageHeight() -> CGFloat {
        var scale = 1.cgFloat
        if let tryScale = (imageBrief?.scale ?? imageDetail?.scale) {
            scale = tryScale.cgFloat
        }
        return scale * UIScreen.main.bounds.size.width
    }
}
