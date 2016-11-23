

import Foundation

class PublishModel {

    var preset: String!
    var image: UIImage!

    var uploadFinished = false
    var uploadError: String?

    func headImageHeight() -> CGFloat {
        var scale = 1.f()
        if let tryScale = image?.aspectRatio() {
            scale = tryScale
        }
        return scale * UIScreen.main.bounds.size.width
    }
}
