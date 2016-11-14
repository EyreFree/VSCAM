

import UIKit

class RegisteTableViewItem: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "RegisteTableViewItem"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        let tryController = (tableView as? RegisteTableView)?.parentViewController as? LoginRegisteController

        //图标
        if let _ = cell.contentView.viewWithTag(Tag.make(13)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.tag = Tag.make(13)
            view.image = UIImage(named: "图标_小笔")
            view.contentMode = .scaleAspectFit
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(19)
                make.height.equalTo(41)
                make.top.equalTo(103)
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
                make.top.equalTo(194)
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
                searchField.clipsToBounds = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: "中英日数字_", attributes: [
                        NSParagraphStyleAttributeName: centeredParagraphStyle,
                        NSForegroundColorAttributeName : UIColor(valueRGB: 0x878787),
                        NSFontAttributeName : UIFont.systemFont(ofSize: 14)
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
                make.top.equalTo(247)
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
                searchField.clipsToBounds = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: "@", attributes: [
                        NSParagraphStyleAttributeName: centeredParagraphStyle,
                        NSForegroundColorAttributeName : UIColor(valueRGB: 0x878787),
                        NSFontAttributeName : UIFont.systemFont(ofSize: 14)
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
                make.top.equalTo(300)
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
                searchField.clipsToBounds = true
                searchField.textAlignment = .center
                let centeredParagraphStyle = NSMutableParagraphStyle()
                centeredParagraphStyle.alignment = .center
                let attributedPlaceholder = NSAttributedString(
                    string: "******", attributes: [
                        NSParagraphStyleAttributeName: centeredParagraphStyle,
                        NSForegroundColorAttributeName : UIColor(valueRGB: 0x878787),
                        NSFontAttributeName : UIFont.systemFont(ofSize: 14)
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
            view.setTitle("加入", for: .normal)
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = true
            view.setTitleColor(UIColor.white, for: .normal)
            view.backgroundColor = UIColor(valueRGB: 0xA6A547)
            view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            view.addTarget(tryController, action: Selector(("registeClicked")), for: .touchUpInside)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.top.equalTo(379)
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
                make.top.equalTo(430)
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
                    UITapGestureRecognizer(target: tryController, action: Selector(("switchToLogin")))
                )
                tryBottomFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.center.equalTo(tryBottomFrameView)
                    make.width.equalTo(86)
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
                    imgView.text = "　已有账号？"
                    imgView.font = UIFont.boldSystemFont(ofSize: 13)
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
                    view.setTitle("登录", for: .normal)
                    view.setTitleColor(UIColor.black, for: .normal)
                    view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    view.addTarget(tryController, action: Selector(("switchToLogin")), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(22)
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

