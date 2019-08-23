
import Foundation

class PublishModel {

    var preset: String!
    var imageData: Data!
    var image: UIImage?

    var uploadFinished = false
    var uploadError: String?
    var uploadResult: PhotoUploadObject?

    func headImageHeight() -> CGFloat {
        var scale = 1.cgFloat
        if let tryScale = image?.aspectRatio() {
            scale = tryScale
        }
        return scale * UIScreen.main.bounds.size.width
    }
}
