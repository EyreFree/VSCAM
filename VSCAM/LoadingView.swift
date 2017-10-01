

import UIKit
import JGProgressHUD

class LoadingView: UIView {

    static let sharedInstance = LoadingView()

    var isVisible = false
    var loadingView: JGProgressHUD!

    func show(controller: UIViewController, title: String? = nil, isTop: Bool = false) {
        if !isVisible {
            isVisible = true
            loadingView = JGProgressHUD(style: .extraLight)
            loadingView.layoutChangeAnimationDuration = 0
            loadingView.textLabel.text = title
            //loadingView.indicatorView = MUGProgressIndicator()
            loadingView.show(in: isTop ? controller.topView() : controller.view, animated: false)
        }
    }

    func hide(result: String? = nil, isError: Bool = true) {
        if let tryResult = result {
            if isError {
                loadingView?.indicatorView = JGProgressHUDErrorIndicatorView()
            } else {
                loadingView?.indicatorView = JGProgressHUDSuccessIndicatorView()
            }
            loadingView?.textLabel.text = tryResult
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingView?.dismiss(animated: false)
                self.isVisible = false
            }
        } else {
            loadingView?.dismiss()
            isVisible = false
        }
    }
}

class MUGProgressIndicator: JGProgressHUDIndicatorView {

    init() {
        let rotateView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rotateView.layer.contents = UIImage(named: "fadai")?.cgImage

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        //rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = Float.infinity

        rotateView.layer.add(rotationAnimation, forKey: "Rotation")

        super.init(contentView: rotateView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

