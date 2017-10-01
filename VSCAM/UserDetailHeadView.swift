
import UIKit
import SnapKit

class UserDetailHeadView: UIView {

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
        self.backgroundColor = UIColor.white

        addControls(reloadImage: true, replace: true)
    }

    func refreshData(reloadImage: Bool, replace: Bool = false) {
        addControls(reloadImage: reloadImage, replace: replace)
    }

    func addControls(reloadImage: Bool = false, replace: Bool = false) {
        if let tryModel = (parentViewController as? UserDetailController)?.model {

            //是否有头像
            let hasAvatar = tryModel.hasAvatar

            //头像
            var avatarViewReal: UIImageView!
            if let view = self.viewWithTag(Tag.make(7)) as? UIImageView {
                avatarViewReal = view
            } else {
                let view = UIImageView()
                view.layer.masksToBounds = true
                view.layer.cornerRadius = 50
                view.backgroundColor = UIColor(valueRGB: 0x222222)
                view.contentMode = .scaleAspectFill
                view.tag = Tag.make(7)
                self.addSubview(view)
                view.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(72)
                    make.centerX.equalTo(self)
                    make.width.height.equalTo(100)
                }
                avatarViewReal = view
            }
            avatarViewReal.isHidden = !hasAvatar
            if reloadImage && hasAvatar {
                if let tryUrl = tryModel.userData?.avatarUrl() ?? tryModel.userDetailData?.avatarUrl() {
                    avatarViewReal.setImageWithURLString(UrlString: tryUrl, placeholder: UIImage.placeholderUser)
                } else {
                    avatarViewReal.image = UIImage.placeholderUser
                }
            }

            //昵称
            let userString = (tryModel.userData?.name ?? tryModel.userDetailData?.name) ?? Define.placeHolderString
            if let view = self.viewWithTag(Tag.make(8)) as? UILabel {
                view.text = userString
                if replace {
                    view.snp.remakeConstraints {
                        (make) -> Void in
                        if hasAvatar {
                            make.top.equalTo(181)
                            make.height.equalTo(26)
                        } else {
                            make.top.equalTo(106)
                            make.height.equalTo(40)
                        }
                        make.left.equalTo(25)
                        make.right.equalTo(-25)
                    }
                    view.font = UIFont.systemFont(ofSize: hasAvatar ? 24 : 36)
                }
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(8)
                imgView.text = userString
                imgView.font = UIFont.systemFont(ofSize: hasAvatar ? 24 : 36)
                imgView.textColor = UIColor.black
                imgView.textAlignment = .center
                self.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    if hasAvatar {
                        make.top.equalTo(181)
                        make.height.equalTo(26)
                    } else {
                        make.top.equalTo(106)
                        make.height.equalTo(40)
                    }
                    make.left.equalTo(25)
                    make.right.equalTo(-25)
                }
            }

            //描述
            let desString = tryModel.userDetailData?.des ?? ""
            if let view = self.viewWithTag(Tag.make(9)) as? UILabel {
                view.text = desString
                if replace {
                    view.snp.remakeConstraints {
                        (make) -> Void in
                        if hasAvatar {
                            make.top.equalTo(218)
                        } else {
                            make.top.equalTo(148)
                        }
                        make.height.equalTo(15)
                        make.left.equalTo(25)
                        make.right.equalTo(-25)
                    }
                }
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(9)
                imgView.text = desString
                imgView.font = UIFont.systemFont(ofSize: 12)
                imgView.textColor = UIColor(valueRGB: 0x878787)
                imgView.textAlignment = .center
                self.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    if hasAvatar {
                        make.top.equalTo(218)
                    } else {
                        make.top.equalTo(148)
                    }
                    make.height.equalTo(15)
                    make.left.equalTo(25)
                    make.right.equalTo(-25)
                }
            }
        }
    }
}
