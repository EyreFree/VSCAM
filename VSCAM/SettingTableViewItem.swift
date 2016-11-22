

import UIKit
import KMPlaceholderTextView

class SettingTableViewItem: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "SettingTableViewItem"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        let tryController = (tableView as? SettingTableView)?.parentViewController as? SettingController

        //图标背景
        if let _ = cell.contentView.viewWithTag(Tag.make(15)) {

        } else {
            let view = UIView()
            view.tag = Tag.make(15)
            view.layer.cornerRadius = 50
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor(valueRGB: 0x222222)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.height.equalTo(100)
                make.top.equalTo(72)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //图标
        var avatarView: UIImageView!
        if let view = cell.contentView.viewWithTag(Tag.make(3)) as? UIImageView {
            avatarView = view
        } else {
            let view = UIImageView()
            view.tag = Tag.make(3)
            view.layer.cornerRadius = 50
            view.layer.masksToBounds = true
            view.alpha = 0.75
            view.isUserInteractionEnabled = true
            view.contentMode = .scaleAspectFill
            view.backgroundColor = UIColor(valueRGB: 0x222222)
            view.image = UIImage.placeholderTransparent
            view.addGestureRecognizer(
                UIGestureRecognizer(
                    target: tryController, action: #selector(SettingController.changeAvatarClicked)
                )
            )
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.height.equalTo(100)
                make.top.equalTo(72)
                make.centerX.equalTo(cell.contentView)
            }
            avatarView = view
        }
        if let tryUrl = Variable.loginUserInfo?.avatarUrl() {
            avatarView?.setImageWithURLString(UrlString: tryUrl, placeholder: UIImage.placeholderUser)
        } else {
            avatarView?.image = UIImage.placeholderUser
        }

        //换头像
        if let _ = cell.contentView.viewWithTag(Tag.make(14)) as? UIButton {

        } else {
            let titleView = UIButton()
            titleView.tag = Tag.make(14)
            titleView.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            titleView.setTitleColor(UIColor.white, for: .normal)
            titleView.addTarget(
                tryController, action: #selector(SettingController.changeAvatarClicked), for: .touchUpInside
            )
            titleView.setTitle("更换", for: .normal)
            cell.contentView.addSubview(titleView)
            titleView.snp.makeConstraints {
                (make) -> Void in
                make.width.height.equalTo(100)
                make.top.equalTo(72)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //用户名
        let name = Variable.loginUserInfo?.name ?? ""
        if let titleView = cell.contentView.viewWithTag(Tag.make(13)) as? UILabel {
            titleView.text = name
        } else {
            let titleView = UILabel()
            titleView.tag = Tag.make(13)
            titleView.font = UIFont.systemFont(ofSize: 24)
            titleView.textColor = UIColor.black
            titleView.text = name
            titleView.textAlignment = .center
            cell.contentView.addSubview(titleView)

            titleView.snp.makeConstraints {
                (make) -> Void in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(183)
                make.height.equalTo(24)
            }
        }

        //一句话
        var editUserFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(4)) {
            editUserFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(4)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: tryController, action: #selector(SettingController.editFrameClicked(recognizer:))
                )
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(226)
                make.height.equalTo(66)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editUserFrameView = imgView
        }

        if let tryEditUserFrameView = editUserFrameView {
            if let view = tryEditUserFrameView.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView {
                view.text = Variable.loginUserInfo?.des
            } else {
                let searchField = KMPlaceholderTextView()
                searchField.tag = Tag.make(5)
                searchField.isSecureTextEntry = false
                searchField.keyboardType = .default
                searchField.returnKeyType = .next
                searchField.bounces = false
                searchField.backgroundColor = UIColor.clear
                searchField.showsHorizontalScrollIndicator = false
                searchField.font = UIFont.systemFont(ofSize: 12)
                searchField.textColor = UIColor.black
                searchField.text = Variable.loginUserInfo?.des
                searchField.textAlignment = .left
                searchField.contentInset = UIEdgeInsets.init(top: -6, left: -3, bottom: 6, right: 3)
                searchField.placeholder = "关于我的一句话自我介绍"
                searchField.placeholderFont = UIFont.systemFont(ofSize: 12)
                searchField.placeholderColor = UIColor(valueRGB: 0x878787)
                searchField.delegate = tryController
                tryEditUserFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //URL
        var editPasswordFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(6)) {
            editPasswordFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(6)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: tryController,
                    action: #selector(SettingController.editFrameClicked(recognizer:))
                )
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(306)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editPasswordFrameView = imgView
        }

        if let tryEditPasswordFrameView = editPasswordFrameView {
            if let view = tryEditPasswordFrameView.viewWithTag(Tag.make(7)) as? UITextField {
                view.text = Variable.loginUserInfo?.url
            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 12)
                searchField.textColor = UIColor.black
                searchField.text = Variable.loginUserInfo?.url
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.done
                searchField.enablesReturnKeyAutomatically = true
                searchField.clipsToBounds = true
                searchField.textAlignment = .left
                let attributedPlaceholder = NSAttributedString(
                    string: "个人博客 or 个人网站", attributes: [
                        NSForegroundColorAttributeName : UIColor(valueRGB: 0x878787),
                        NSFontAttributeName : UIFont.systemFont(ofSize: 12)
                    ]
                )
                searchField.attributedPlaceholder = attributedPlaceholder
                searchField.clearButtonMode = UITextFieldViewMode.whileEditing
                searchField.delegate = tryController
                searchField.tag = Tag.make(7)
                tryEditPasswordFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //按钮
        if let _ = cell.contentView.viewWithTag(Tag.make(8)) as? UIButton {

        } else {
            let view = UIButton(type: .system)
            view.tag = Tag.make(8)
            view.setTitle("确认更改", for: .normal)
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = true
            view.setTitleColor(UIColor.white, for: .normal)
            view.backgroundColor = UIColor(valueRGB: 0xA6A547)
            view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            view.addTarget(tryController, action: Selector(("changeClicked")), for: .touchUpInside)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.top.equalTo(384)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //底部边框
        var bottomFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(9)) {
            bottomFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(9)
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(475)
                make.left.right.bottom.equalTo(0)
            }
            bottomFrameView = imgView
        }

        if let tryBottomFrameView = bottomFrameView {
            //底部内边框
            var bottomFrameInView: UIView?
            if let view = tryBottomFrameView.viewWithTag(Tag.make(10)) {
                bottomFrameInView = view
            } else {
                let imgView = UIView()
                imgView.tag = Tag.make(10)
                tryBottomFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.center.equalTo(tryBottomFrameView)
                    make.width.equalTo(60)
                    make.height.equalTo(66)
                }
                bottomFrameInView = imgView
            }

            if let tryBottomFrameInView = bottomFrameInView {
                //删除头像
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(11)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(11)
                    view.setTitle("删除头像", for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: Selector(("deleteAvatarClicked")), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.top.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }

                //退出登录
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(12)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(12)
                    view.setTitle("退出登录", for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0xD0021B), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: Selector(("logoutClicked")), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }
            }
        }

        return cell
    }

    override func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return CGSize.screen().height
    }
    
    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

