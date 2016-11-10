

import UIKit
import SnapKit

class ImageDetailHeadView: UIView {

    weak var parentViewController: UIViewController!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    init(_ parentViewController: UIViewController) {
        super.init(frame: CGRect.zero)

        self.parentViewController = parentViewController
        onInit()
    }

    func onInit() {
        addControls()
    }

    func addControls() {
        //背景
        if let _ = self.viewWithTag(Tag.make(0)) {

        } else {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            view.layer.masksToBounds = false
            view.tag = Tag.make(0)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
        }

        //左侧按钮
        if let _ = self.viewWithTag(Tag.make(1)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_返回_白")
            view.tag = Tag.make(1)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: parentViewController, action: Selector(("backClicked")))
            )
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //右侧按钮
        if let _ = self.viewWithTag(Tag.make(2)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_更多")
            view.tag = Tag.make(2)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: parentViewController, action: Selector(("shareClicked")))
            )
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }
    }
}

