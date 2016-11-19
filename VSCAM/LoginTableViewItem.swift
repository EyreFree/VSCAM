

import UIKit

class LoginTableViewItem: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "LoginTableViewItem"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        let tryController = (tableView as? LoginTableView)?.parentViewController as? LoginRegisteController

        //图标
        if let _ = cell.contentView.viewWithTag(Tag.make(3)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.tag = Tag.make(3)
            view.image = UIImage(named: "图标_小人")
            view.contentMode = .scaleAspectFit
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(17)
                make.height.equalTo(29)
                make.top.equalTo(122)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //用户名
        var editUserFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(4)) {
            editUserFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(4)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.editFrameClicked(recognizer:)))
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(216)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editUserFrameView = imgView
        }

        if let tryEditUserFrameView = editUserFrameView {
            if let _ = tryEditUserFrameView.viewWithTag(Tag.make(5)) as? UITextField {

            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 14)
                searchField.textColor = UIColor.black
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.next
                searchField.clipsToBounds = true
                searchField.text = Variable.lastLoginUser
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
                //searchField.clearButtonMode = UITextFieldViewMode.whileEditing
                searchField.delegate = tryController
                searchField.tag = Tag.make(5)
                tryEditUserFrameView.addSubview(searchField)
                searchField.snp.makeConstraints {
                    (make) -> Void in
                    make.left.top.equalTo(4)
                    make.right.bottom.equalTo(-4)
                }
            }
        }

        //密码
        var editPasswordFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(6)) {
            editPasswordFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(6)
            imgView.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            imgView.addGestureRecognizer(
                UITapGestureRecognizer(target: tryController, action: #selector(LoginRegisteController.editFrameClicked(recognizer:)))
            )
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(269)
                make.height.equalTo(39)
                make.left.equalTo(51)
                make.right.equalTo(-51)
            }
            editPasswordFrameView = imgView
        }

        if let tryEditPasswordFrameView = editPasswordFrameView {
            if let _ = tryEditPasswordFrameView.viewWithTag(Tag.make(7)) as? UITextField {

            } else {
                let searchField = UITextField(frame: CGRect.zero)
                searchField.font = UIFont.systemFont(ofSize: 14)
                searchField.textColor = UIColor.black
                searchField.backgroundColor = UIColor.clear
                searchField.keyboardType = .default
                searchField.returnKeyType = UIReturnKeyType.done
                searchField.clipsToBounds = true
                searchField.isSecureTextEntry = true
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
                //searchField.clearButtonMode = UITextFieldViewMode.whileEditing
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
            view.setTitle("登录", for: .normal)
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = true
            view.setTitleColor(UIColor.white, for: .normal)
            view.backgroundColor = UIColor(valueRGB: 0xA6A547)
            view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            view.addTarget(tryController, action: Selector(("loginClicked")), for: .touchUpInside)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.top.equalTo(348)
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
                make.top.equalTo(430)
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
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(
                    UITapGestureRecognizer(target: tryController, action: Selector(("switchToRegiste")))
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
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(11)) as? UILabel {

                } else {
                    let imgView = UILabel()
                    imgView.tag = Tag.make(11)
                    imgView.text = "　尚未注册？"
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
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(12)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(12)
                    view.setTitle("加入", for: .normal)
                    view.setTitleColor(UIColor.black, for: .normal)
                    view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    view.addTarget(tryController, action: Selector(("switchToRegiste")), for: .touchUpInside)
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

