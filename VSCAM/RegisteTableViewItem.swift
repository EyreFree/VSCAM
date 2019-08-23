
import UIKit

class RegisteTableViewItem: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none

        let tryController = (tableView as? RegisteTableView)?.parentViewController as? LoginRegisteController

        //图标
        if let _ = cell.contentView.viewWithTag(Tag.make(13)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.tag = Tag.make(13)
            view.image = R.image.图标_小笔()
            view.contentMode = .scaleAspectFit
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(19)
                make.height.equalTo(41)
                make.top.equalTo(113)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //昵称
        var editUserFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(14)) {
            editUserFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(14)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.editFrameClicked(recognizer:)))
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(184)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editUserFrameView = imgView
        }

        if let tryEditUserFrameView = editUserFrameView {
            if let _ = tryEditUserFrameView.viewWithTag(Tag.make(15)) as? UITextField {

            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 14)
                searchField.textColor = UIColor.black
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.next
                searchField.enablesReturnKeyAutomatically = true
                searchField.clipsToBounds = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: String.Localized("中英日数字_"), attributes: [
                        NSAttributedString.Key.paragraphStyle: centeredParagraphStyle,
                        NSAttributedString.Key.foregroundColor : UIColor(valueRGB: 0x878787),
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
                    ]
                )
                searchField.attributedPlaceholder = attributedPlaceholder
                searchField.delegate = tryController
                searchField.tag = Tag.make(15)
                tryEditUserFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //邮箱
        var editEmailFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(16)) {
            editEmailFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(16)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.editFrameClicked(recognizer:)))
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(237)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editEmailFrameView = imgView
        }

        if let tryEditEmailFrameView = editEmailFrameView {
            if let _ = tryEditEmailFrameView.viewWithTag(Tag.make(17)) as? UITextField {

            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 14)
                searchField.textColor = UIColor.black
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.next
                searchField.enablesReturnKeyAutomatically = true
                searchField.clipsToBounds = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: "@", attributes: [
                        NSAttributedString.Key.paragraphStyle: centeredParagraphStyle,
                        NSAttributedString.Key.foregroundColor : UIColor(valueRGB: 0x878787),
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
                    ]
                )
                searchField.attributedPlaceholder = attributedPlaceholder
                searchField.delegate = tryController
                searchField.tag = Tag.make(17)
                tryEditEmailFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //密码
        var editPasswordFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(18)) {
            editPasswordFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(18)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.editFrameClicked(recognizer:)))
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(290)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editPasswordFrameView = imgView
        }

        if let tryEditPasswordFrameView = editPasswordFrameView {
            if let _ = tryEditPasswordFrameView.viewWithTag(Tag.make(19)) as? UITextField {

            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 14)
                searchField.textColor = UIColor.black
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.done
                searchField.enablesReturnKeyAutomatically = true
                searchField.clipsToBounds = true
                searchField.isSecureTextEntry = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: "******", attributes: [
                        NSAttributedString.Key.paragraphStyle: centeredParagraphStyle,
                        NSAttributedString.Key.foregroundColor : UIColor(valueRGB: 0x878787),
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
                    ]
                )
                searchField.attributedPlaceholder = attributedPlaceholder
                searchField.delegate = tryController
                searchField.tag = Tag.make(19)
                tryEditPasswordFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //按钮
        if let _ = cell.contentView.viewWithTag(Tag.make(20)) as? UIButton {

        } else {
            let view = UIButton(type: .system)
            view.tag = Tag.make(20)
            view.setTitle(String.Localized("加入"), for: .normal)
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = true
            view.isEnabled = false
            view.backgroundColor = UIColor.gray
            view.setTitleColor(UIColor.white, for: .normal)
            view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            view.addTarget(tryController, action: #selector(LoginRegisteController.registeClicked), for: .touchUpInside)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.top.equalTo(400)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //底部边框
        var bottomFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(21)) {
            bottomFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(21)
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(450)
                make.left.right.bottom.equalTo(0)
            }
            bottomFrameView = imgView
        }

        if let tryBottomFrameView = bottomFrameView {
            //底部内边框
            var bottomFrameInView: UIView?
            if let view = tryBottomFrameView.viewWithTag(Tag.make(22)) {
                bottomFrameInView = view
            } else {
                let imgView = UIView()
                imgView.tag = Tag.make(22)
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(
                    UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.switchToLogin))
                )
                tryBottomFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.center.equalTo(tryBottomFrameView)
                    make.width.greaterThanOrEqualTo(86)
                    make.height.equalTo(51)
                }
                bottomFrameInView = imgView
            }

            if let tryBottomFrameInView = bottomFrameInView {
                //切换提示
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(23)) as? UILabel {

                } else {
                    let imgView = UILabel()
                    imgView.tag = Tag.make(23)
                    imgView.text = String.Localized("　已有账号？")
                    imgView.font = UIFont.systemFont(ofSize: 13)
                    imgView.textAlignment = .center
                    imgView.textColor = UIColor(valueRGB: 0x878787)
                    tryBottomFrameInView.addSubview(imgView)
                    imgView.snp.makeConstraints {
                        (make) -> Void in
                        make.top.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }

                //切换按钮
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(24)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(24)
                    view.setTitle(String.Localized("登录"), for: .normal)
                    view.setTitleColor(UIColor.black, for: .normal)
                    view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    view.addTarget(tryController, action: #selector(LoginRegisteController.switchToLogin), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(22)
                    }
                }
            }
        }

        //用户协议外框
        var agreementFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(25)) {
            agreementFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(25)
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.width.greaterThanOrEqualTo(107)
                make.height.equalTo(16)
                make.centerX.equalTo(cell)
                make.top.equalTo(358)
            }
            agreementFrameView = imgView
        }

        if let tryAgreementFrameView = agreementFrameView {

            //是否同意协议
            let agree = tryController?.model.agree.value == true

            //选择圆圈
            if let view = tryAgreementFrameView.viewWithTag(Tag.make(26)) as? UIImageView {
                view.image = agree ? R.image.图标_选择_是() : R.image.图标_选择_否()
            } else {
                let view = UIImageView()
                view.tag = Tag.make(26)
                view.image = agree ? R.image.图标_选择_是() : R.image.图标_选择_否()
                view.contentMode = .scaleAspectFit
                tryAgreementFrameView.addSubview(view)
                view.snp.makeConstraints {
                    (make) -> Void in
                    make.width.height.equalTo(16)
                    make.left.equalTo(0)
                    make.centerY.equalTo(tryAgreementFrameView)
                }
            }
            
            //文字
            var agreeTextView: UILabel!
            if let view = tryAgreementFrameView.viewWithTag(Tag.make(27)) as? UILabel {
                agreeTextView = view
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(27)
                imgView.text = String.Localized("      同意")
                imgView.font = UIFont.systemFont(ofSize: 13)
                imgView.textAlignment = .left
                imgView.textColor = UIColor(valueRGB: 0x878787)
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(
                    UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.agreeClicked))
                )
                imgView.sizeToFit()
                tryAgreementFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.left.bottom.equalTo(0)
                    make.width.equalTo(imgView.frame.width)
                }
                agreeTextView = imgView
            }

            //用户协议
            if let _ = tryAgreementFrameView.viewWithTag(Tag.make(28)) as? UILabel {

            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(28)
                imgView.text = String.Localized("用户协议")
                imgView.font = UIFont.systemFont(ofSize: 13)
                imgView.textAlignment = .center
                imgView.textColor = UIColor(valueRGB: 0xA6A547)
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(
                    UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.agreementClicked))
                )
                imgView.sizeToFit()
                tryAgreementFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.bottom.right.equalTo(0)
                    make.left.equalTo(agreeTextView.snp.right).offset(3)
                    make.width.equalTo(imgView.frame.width)
                }
            }
        }

        return cell
    }
    
    override func height(tableView: UITableView) -> CGFloat {
        return CGSize.screen().height
    }
}
