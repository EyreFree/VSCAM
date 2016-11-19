

import UIKit
import KMPlaceholderTextView

class SettingController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {

    var tableView: SettingTableView!
    var model: SettingModel!

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
            self, selector: #selector(SettingController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(SettingController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func addModel() {
        model = SettingModel()
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
                UITapGestureRecognizer(target: self, action: #selector(SettingController.backClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        if let _ = self.view.viewWithTag(Tag.make(1)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_更多_黑")
            view.tag = Tag.make(1)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(SettingController.shareClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addTableView
        if let _ = self.view.viewWithTag(Tag.make(2)) as? SettingTableView {

        } else {
            let view = SettingTableView(self)
            view.tag = Tag.make(2)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubview(toBack: view)
            self.tableView = view
        }
    }

    func backClicked() {
        Function.HideKeyboard()
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }

    func shareClicked() {
        Function.HideKeyboard()
        if let tryName = Variable.loginUserInfo?.name {
            let webUrl = NetworkURL.userDetailPage.replace(string: "{name}", with: tryName)
            Function.openShareView(controller: self, title: "[VSCAM]\(tryName)", url: webUrl)
        }
    }

    func changeAvatarClicked() {
        Function.HideKeyboard()
        print("修改头像")
    }

    func changeClicked() {
        Function.HideKeyboard()
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.contentView
        if let tryID = (cell?.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView)?.text?.clean(),
            let tryPWD = (cell?.viewWithTag(Tag.make(7)) as? UITextField)?.text?.clean() {

            print(tryID)
            print(tryPWD)
            /*if false == tryID.conform(regex: "/^(|.+)$/") {
             Function.MessageBox(self, title: "提示", content: "自我介绍格式错误")
             return
             }*/
            /*if false == tryPWD.conform(regex: "/^(|@[\\x{0800}-\\x{9fa5}\\w_-]+|(http|https)\\:\\/\\/[\\w\\/.#&!?%:;=\\-_]+)$/iu") {
             Function.MessageBox(self, title: "提示", content: "URL 格式错误")
             return
             }*/
            //            NetworkAPI.sharedInstance.login(id: tryID, password: tryPWD) {
            //                [weak self] (errorString) in
            //                if let trySelf = self {
            //                    if let tryErrorString = errorString {
            //                        Function.MessageBox(trySelf, title: "登录失败", content: tryErrorString)
            //                    } else {
            //                        Variable.loginNeedRefreshMain = true
            //                        MainNavigationController.sharedInstance.popViewController(animated: true)
            //                    }
            //                }
            //            }
        }
    }

    func deleteAvatarClicked() {
        Function.HideKeyboard()
        print("删除头像")
    }

    func logoutClicked() {
        Function.HideKeyboard()
        print("退出登录")
    }

    func editFrameClicked(recognizer: UIGestureRecognizer) {
        if let tryTag = recognizer.view?.tag {
            (recognizer.view?.viewWithTag(tryTag + 1) as? UITextField)?.becomeFirstResponder()
        }
    }

    //键盘出现
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let tryHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)

                //找到当前焦点编辑框并且滚到那里去
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.contentView

                let visibleHeight = CGSize.screen().height - tryHeight
                if (cell?.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView)?.isFirstResponder == true {
                    self.tableView.setContentOffset(CGPoint(x: 0, y: max(226 - (visibleHeight - 66) / 2, 0)))
                } else if (cell?.viewWithTag(Tag.make(7)) as? UITextField)?.isFirstResponder == true {
                    self.tableView.setContentOffset(CGPoint(x: 0, y: max(306 - (visibleHeight - 39) / 2, 0)))
                }
            }
        }
    }

    //键盘消失
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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

    //MARK:- UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //获得焦点
        textView.superview?.layer.borderWidth = 1
        textView.superview?.layer.borderColor = UIColor(valueRGB: 0xA6A547).cgColor
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //键盘提交
        if text == "\n" {
            if textView.tag == Tag.make(5) {
                (textView.superview?.superview?.viewWithTag(Tag.make(7)) as? UITextField)?.becomeFirstResponder()
            } else {
                textView.resignFirstResponder()
            }
            return false
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        //失去焦点
        textView.superview?.layer.borderWidth = 0
        textView.superview?.layer.borderColor = UIColor.clear.cgColor
        return true
    }
}

