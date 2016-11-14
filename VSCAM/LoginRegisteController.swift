

import UIKit

class LoginRegisteController: BaseViewController, UITextFieldDelegate {

    var tableViewLogin: LoginTableView!
    var tableViewRegiste: RegisteTableView!
    var model: LoginRegisteModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addModel()
        addControls()

        //
        addKeyboardObserver()
    }

    deinit {
        //移除观察者
        removeKeyboardObserver()
    }

    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(LoginRegisteController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(LoginRegisteController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func addModel() {
        model = LoginRegisteModel()
    }

    func addControls() {
        //buttons
        if let _ = self.view.viewWithTag(Tag.make(0)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_返回_黑")
            view.tag = Tag.make(0)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(LoginRegisteController.backClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addTableView
        if let _ = self.view.viewWithTag(Tag.make(1)) as? LoginTableView {

        } else {
            let view = LoginTableView(self)
            view.tag = Tag.make(1)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubview(toBack: view)
            self.tableViewLogin = view
        }

        if let _ = self.view.viewWithTag(Tag.make(2)) as? RegisteTableView {

        } else {
            let view = RegisteTableView(self)
            view.tag = Tag.make(2)
            view.isHidden = true
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubview(toBack: view)
            self.tableViewRegiste = view
        }
    }

    func backClicked() {
        Function.HideKeyboard()
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }

    func loginClicked() {

    }

    func registeClicked() {

    }

    func switchToLogin() {
        switchClicked(title: "登录")
    }

    func switchToRegiste() {
        switchClicked(title: "加入")
    }

    func switchClicked(title: String) {
        Function.HideKeyboard()

        switch title {
        case "加入":
            tableViewRegiste.alpha = 0
            tableViewRegiste.isHidden = false
            UIView.animate(withDuration: 0.38, animations: {
                [weak self] in
                if let trySelf = self {
                    trySelf.tableViewRegiste.alpha = 1
                    trySelf.tableViewLogin.alpha = 0
                }
            }) {
                [weak self] (_) in
                if let trySelf = self {
                    trySelf.tableViewLogin.isHidden = true
                }
            }
            break
        case "登录":
            tableViewLogin.alpha = 0
            tableViewLogin.isHidden = false
            UIView.animate(withDuration: 0.38, animations: {
                [weak self] in
                if let trySelf = self {
                    trySelf.tableViewLogin.alpha = 1
                    trySelf.tableViewRegiste.alpha = 0
                }
            }) {
                [weak self] (_) in
                if let trySelf = self {
                    trySelf.tableViewRegiste.isHidden = true
                }
            }
            break
        default:
            break
        }
    }

    func editFrameClicked(recognizer: UIGestureRecognizer) {
        if let tryTag = recognizer.view?.tag {
            switch tryTag {
            case Tag.make(4), Tag.make(6):
                (recognizer.view?.viewWithTag(tryTag + 1) as? UITextField)?.becomeFirstResponder()
                break
            case Tag.make(14), Tag.make(16), Tag.make(18):
                (recognizer.view?.viewWithTag(tryTag + 1) as? UITextField)?.becomeFirstResponder()
                break
            default:
                break
            }
        }
    }

    //键盘出现
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let tryHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                self.tableViewLogin.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)
                self.tableViewRegiste.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)

                //找到当前焦点编辑框并且滚到那里去
                let cellLogin = self.tableViewLogin.cellForRow(at: IndexPath(row: 0, section: 0))?.contentView
                let cellRegiste = self.tableViewRegiste.cellForRow(at: IndexPath(row: 0, section: 0))?.contentView

                let visibleHeight = CGSize.screen().height - tryHeight
                if (cellLogin?.viewWithTag(Tag.make(5)) as? UITextField)?.isFirstResponder == true {
                    self.tableViewLogin.setContentOffset(CGPoint(x: 0, y: max(216 - (visibleHeight - 39) / 2, 0)))
                } else if (cellLogin?.viewWithTag(Tag.make(7)) as? UITextField)?.isFirstResponder == true {
                    self.tableViewLogin.setContentOffset(CGPoint(x: 0, y: max(269 - (visibleHeight - 39) / 2, 0)))
                } else if (cellRegiste?.viewWithTag(Tag.make(15)) as? UITextField)?.isFirstResponder == true {
                    self.tableViewRegiste.setContentOffset(CGPoint(x: 0, y: max(194 - (visibleHeight - 39) / 2, 0)))
                } else if (cellRegiste?.viewWithTag(Tag.make(17)) as? UITextField)?.isFirstResponder == true {
                    self.tableViewRegiste.setContentOffset(CGPoint(x: 0, y: max(247 - (visibleHeight - 39) / 2, 0)))
                } else if (cellRegiste?.viewWithTag(Tag.make(19)) as? UITextField)?.isFirstResponder == true {
                    self.tableViewRegiste.setContentOffset(CGPoint(x: 0, y: max(300 - (visibleHeight - 39) / 2, 0)))
                }
            }
        }
    }

    //键盘消失
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableViewLogin.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableViewRegiste.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    //MARK:- UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //获得焦点
        textField.superview?.layer.borderWidth = 1
        textField.superview?.layer.borderColor = UIColor(valueRGB: 0xA6A547).cgColor
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //键盘提交
        if textField.tag == Tag.make(5) {
            (textField.superview?.superview?.viewWithTag(Tag.make(7)) as? UITextField)?.becomeFirstResponder()
        } else if textField.tag == Tag.make(15) {
            (textField.superview?.superview?.viewWithTag(Tag.make(17)) as? UITextField)?.becomeFirstResponder()
        } else if textField.tag == Tag.make(17) {
            (textField.superview?.superview?.viewWithTag(Tag.make(19)) as? UITextField)?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //失去焦点
        textField.superview?.layer.borderWidth = 0
        textField.superview?.layer.borderColor = UIColor.clear.cgColor
        return true
    }
}

