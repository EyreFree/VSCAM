

import UIKit
import SnapKit

class MainHeadView: UIView {

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

    func setAvatar(url: String) {
        //头像
        var viewReal: UIImageView?
        if let view = self.viewWithTag(Tag.make(1)) as? UIImageView {
            viewReal = view
        } else {
            let view = UIImageView()
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 20
            view.image = UIImage.placeholderUser
            view.tag = Tag.make(1)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.left.equalTo(8)
                make.bottom.equalTo(-8)
                make.width.height.equalTo(40)
            }
            viewReal = view
        }
        viewReal?.setImageWithURLString(UrlString: url)
    }

    func addControls() {
        //背景
        if let _ = self.viewWithTag(Tag.make(0)) {

        } else {
            let view = UIView()
            view.backgroundColor = UIColor(valueRGB: 0xF8F8F8)
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowOpacity = 0.4
            view.tag = Tag.make(0)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
        }

        //头像
        if let _ = self.viewWithTag(Tag.make(1)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 20
            view.image = UIImage.placeholderUser
            view.tag = Tag.make(1)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.left.equalTo(8)
                make.bottom.equalTo(-8)
                make.width.height.equalTo(40)
            }
        }

        //LOGO
        if let _ = self.viewWithTag(Tag.make(2)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = UIImage(named: "logo")
            view.tag = Tag.make(2)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.centerX.equalTo(self)
                make.top.equalTo(32)
                make.width.equalTo(59)
                make.height.equalTo(22)
            }
        }

        //新建按钮
        if let _ = self.viewWithTag(Tag.make(3)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = UIImage(named: "新建按钮")
            view.tag = Tag.make(3)
            self.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(35)
                make.right.equalTo(-17)
                make.width.height.equalTo(18)
            }
        }
    }
}

