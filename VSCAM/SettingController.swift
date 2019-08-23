
import UIKit
import KMPlaceholderTextView
import SDWebImage
import RxSwift
import RxCocoa

class SettingController: BaseViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var tableView: SettingTableView!
    var model: SettingModel!

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addModel()
        addControls()

        //
        addKeyboardObserver()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Function.setStatusBar(hidden: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        addRx()
    }

    deinit {
        //移除观察者
        removeKeyboardObserver()
    }

    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SettingController.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SettingController.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
            view.image = R.image.按钮_返回_黑()
            view.tag = Tag.make(0)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(SettingController.backClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(CGFloat.statusBarHeight - 20)
                make.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        if let _ = self.view.viewWithTag(Tag.make(1)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = R.image.按钮_更多_黑()
            view.tag = Tag.make(1)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(SettingController.shareClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(CGFloat.statusBarHeight - 20)
                make.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addTableView
        if let _ = self.view.viewWithTag(Tag.make(2)) as? SettingTableView {

        } else {
            let view = SettingTableView()
            view.tag = Tag.make(2)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubviewToBack(view)
            self.tableView = view
        }
    }

    func addRx() {
        if let tryDescLabel = self.view.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView,
            let tryUrlLabel = self.view.viewWithTag(Tag.make(7)) as? UITextField,
            let tryConfirmButton = self.view.viewWithTag(Tag.make(8)) as? UIButton {

            Observable.combineLatest(tryDescLabel.rx.text.orEmpty, tryUrlLabel.rx.text.orEmpty) {
                (textDesc, textUrl) -> Bool in
                if textDesc == Variable.loginUserInfo?.des && textUrl == Variable.loginUserInfo?.url {
                    return false
                }
                return true
                }
                .subscribe(onNext: {
                    tryConfirmButton.isEnabled = $0
                    tryConfirmButton.backgroundColor = $0 ? UIColor(valueRGB: 0xA6A547) : UIColor.gray
                })
                .disposed(by: disposeBag)
        }
    }

    @objc func backClicked() {
        Function.HideKeyboard()
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }

    @objc func shareClicked() {
        Function.HideKeyboard()
        if let tryName = Variable.loginUserInfo?.name {
            let webUrl = NetworkURL.userDetailPage.replace(string: "{name}", with: tryName)
            Function.openShareView(controller: self, url: webUrl)
        }
    }

    @objc func changeAvatarClicked() {
        Function.HideKeyboard()

        if nil == imagePicker {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false
            imagePicker = picker
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

    @objc func changeClicked() {
        Function.HideKeyboard()
        if let tryDesc = (self.view.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView)?.text?.clean,
            let tryUrl = (self.view.viewWithTag(Tag.make(7)) as? UITextField)?.text?.clean,
            let tryConfirmButton = self.view.viewWithTag(Tag.make(8)) as? UIButton {

            if tryConfirmButton.isEnabled {
                NetworkAPI.sharedInstance.change(des: tryDesc, url: tryUrl) {
                    [weak self] (errorString) in
                    if let trySelf = self {
                        if let tryErrorString = errorString {
                            Function.MessageBox(trySelf, title: String.Localized("更改失败"), content: tryErrorString)
                        } else {
                            Variable.loginUserInfoSetDes(newValue: tryDesc)
                            Variable.loginUserInfoSetUrl(newValue: tryUrl)

                            Variable.loginNeedRefreshMain = true
                            Function.MessageBox(
                                trySelf, title: String.Localized("提示"), content: String.Localized("更改个人信息成功"), type: .success
                            )

                            tryConfirmButton.isEnabled = false
                            tryConfirmButton.backgroundColor = UIColor.gray
                        }
                    }
                }
            }
        }
    }

    @objc func deleteAvatarClicked() {
        Function.HideKeyboard()

        NetworkAPI.sharedInstance.avatarDelete() {
            [weak self] (errorString) in
            if let trySelf = self {
                if let tryErrorString = errorString {
                    Function.MessageBox(trySelf, title: String.Localized("删除头像失败"), content: tryErrorString)
                } else {
                    Variable.loginUserInfoSetAvatar(newValue: 0)

                    Variable.loginNeedRefreshMain = true
                    trySelf.tableView?.reloadRowsWithoutAnimation(indexPathArray: [IndexPath(row: 0, section: 0)])
                    Function.MessageBox(
                        trySelf, title: String.Localized("提示"), content: String.Localized("删除头像成功"), type: .success
                    )
                }
            }
        }
    }

    @objc func logoutClicked() {
        Function.HideKeyboard()

        NetworkAPI.sharedInstance.logout() {
            [weak self] (errorString) in
            if let trySelf = self {
                if let tryErrorString = errorString {
                    Function.MessageBox(trySelf, title: String.Localized("退出登录失败"), content: tryErrorString)
                } else {
                    Variable.loginUserInfo = nil
                    NetworkCache.cookies = nil
                    Variable.lastLoginPWD = nil
                    Variable.loginNeedRefreshMain = true

                    for controller in MainNavigationController.sharedInstance.viewControllers {
                        if let tryController = controller as? MainController {
                            MainNavigationController.sharedInstance.popToViewController(tryController, animated: true)
                            break
                        }
                    }
                }
            }
        }
    }

    @objc func clearCacheClicked() {
        let cacheSize = Int(SDImageCache.shared.totalDiskSize()).cgFloat / 1024.cgFloat / 1024.cgFloat
        let cacheString = String(format: " %0.2f MB", cacheSize)

        let alert = UIAlertController(
            title: String.Localized("提示"),
            message: String.Localized("缓存大小为") + cacheString + String.Localized("，确定要清理缓存么？"),
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: String.Localized("取消"), style: .cancel, handler: {
                (action) -> Void in
            })
        )
        alert.addAction(
            UIAlertAction(title: String.Localized("确定"), style: .default) {
                [weak self] (action) -> Void in
                if let _ = self {
                    SDImageCache.shared.clearDisk()
                }
            }
        )
        self.present(alert, animated: true, completion: nil)
    }

    @objc func aboutClicked() {
        MainNavigationController.sharedInstance.pushViewController(
            AboutController(), animated: true
        )
    }

    @objc func editFrameClicked(recognizer: UIGestureRecognizer) {
        if let tryTag = recognizer.view?.tag {
            (recognizer.view?.viewWithTag(tryTag + 1) as? UITextField)?.becomeFirstResponder()
        }
    }

    //键盘出现
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let tryHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)

                //找到当前焦点编辑框并且滚到那里去
                let visibleHeight = CGSize.screen().height - tryHeight
                if (self.view.viewWithTag(Tag.make(5)) as? KMPlaceholderTextView)?.isFirstResponder == true {
                    self.tableView.setContentOffset(CGPoint(x: 0, y: max(226 - (visibleHeight - 66) / 2, 0)))
                } else if (self.view.viewWithTag(Tag.make(7)) as? UITextField)?.isFirstResponder == true {
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
        } else if textField.tag == Tag.make(7) {
            changeClicked()
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
            } else if textView.tag == Tag.make(7) {
                changeClicked()
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

    //MARK:- UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }

    private var pickerImage: UIImage!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickerImage = selectImage.copy() as? UIImage

            LoadingView.sharedInstance.show(controller: self)
            NetworkAPI.sharedInstance.avatarSet(avatar: pickerImage) {
                [weak self] (errorString) in
                if let trySelf = self {
                    if let tryErrorString = errorString {
                        Function.MessageBox(trySelf, title: String.Localized("更改头像失败"), content: tryErrorString)
                    } else {
                        Variable.loginUserInfoSetAvatar(newValue: 1)

                        Variable.loginNeedRefreshMain = true

                        if let tryUrlBig = Variable.loginUserInfo?.avatarUrl(),
                            let tryUrlSmall = Variable.loginUserInfo?.avatarUrl(isBig: false) {
                            SDImageCache.shared.store(trySelf.pickerImage, forKey: tryUrlBig, completion: nil)
                            SDImageCache.shared.store(trySelf.pickerImage, forKey: tryUrlSmall, completion: nil)
                        }
                        trySelf.tableView?.reloadRowsWithoutAnimation(indexPathArray: [IndexPath(row: 0, section: 0)])

                        Function.MessageBox(
                            trySelf,
                            title: String.Localized("提示"),
                            content: String.Localized("更改头像成功"),
                            type: .success
                        )
                    }
                    LoadingView.sharedInstance.hide()
                }
            }
        } else {
            Function.MessageBox(self, title: String.Localized("更改头像失败"), content: String.Localized("所选图片无效"))
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    // 修复照片选择器状态栏问题
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController.isKind(of: UIImagePickerController.classForCoder()) {
            Function.setStatusBar(hidden: false)
        }
    }
}
