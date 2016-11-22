

import UIKit
import MJRefresh

class PublishController: BaseViewController, UITextFieldDelegate {

    var tableView: PublishTableView!
    var model: PublishModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(image: UIImage, preset: String) {
        super.init(nibName: nil, bundle: nil)

        addModel()
        model?.preset = preset
        model?.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addControls()

        //
        addKeyboardObserver()

        //上传图片
        NetworkAPI.sharedInstance.upload(pp: model.image, progress: {
            [weak self] (progress) in
            print("upload progress: \(progress)")
        }) {
            [weak self] (photoData, errorString) in
            print("upload complete: \(errorString)")
        }
    }

    deinit {
        //移除观察者
        removeKeyboardObserver()
    }

    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(PublishController.keyboardWillShow(notification:)),
            name: NSNotification.Name.UIKeyboardWillShow, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(PublishController.keyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide, object: nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func addModel() {
        model = PublishModel()
    }

    func addControls() {
        //按钮
        if let _ = self.view.viewWithTag(Tag.make(0)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_关闭")
            view.tag = Tag.make(0)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(PublishController.closeClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addTableView
        if let _ = self.view.viewWithTag(Tag.make(1)) as? PublishTableView {

        } else {
            let view = PublishTableView(self)
            view.tag = Tag.make(1)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubview(toBack: view)
            self.tableView = view
        }

        //底部视图
        var footView: UIView!
        if let view = self.view.viewWithTag(Tag.make(2)) {
            footView = view
        } else {
            let view = UIView()
            view.backgroundColor = UIColor.white
            view.tag = Tag.make(2)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(89)
            }
            footView = view
        }

        var footGreyView: UIView!
        if let view = footView.viewWithTag(Tag.make(3)) {
            footGreyView = view
        } else {
            let view = UIView()
            view.backgroundColor = UIColor(valueRGB: 0xEEEEEE)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UIGestureRecognizer(
                    target: self, action: #selector(PublishController.editFrameClicked(recognizer:))
                )
            )
            view.tag = Tag.make(3)
            footView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(20)
                make.right.bottom.equalTo(-20)
            }
            footGreyView = view
        }

        if let _ = footGreyView.viewWithTag(Tag.make(4)) as? UITextField {

        } else {
            let searchField = UITextField()
            searchField.font = UIFont.systemFont(ofSize: 16)
            searchField.textColor = UIColor.black
            searchField.backgroundColor = UIColor.clear
            searchField.keyboardType = .default
            searchField.returnKeyType = UIReturnKeyType.send
            searchField.enablesReturnKeyAutomatically = true
            searchField.clipsToBounds = true
            searchField.textAlignment = .left
            let attributedPlaceholder = NSAttributedString(
                string: "输入一句话照片简介", attributes: [
                    NSForegroundColorAttributeName : UIColor(valueRGB: 0x535353),
                    NSFontAttributeName : UIFont.systemFont(ofSize: 16)
                ]
            )
            searchField.attributedPlaceholder = attributedPlaceholder
            searchField.delegate = self
            searchField.tag = Tag.make(4)
            footGreyView.addSubview(searchField)
            searchField.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(8)
                make.bottom.equalTo(-8)
                make.left.equalTo(10)
                make.right.equalTo(-10)
            }

            //获得焦点
            searchField.becomeFirstResponder()
        }

        //滤镜
        if let _ = self.view.viewWithTag(Tag.make(5)) as? UILabel {

        } else {
            let searchField = UILabel()
            searchField.alpha = 0.5
            searchField.text = model.preset
            searchField.font = UIFont.systemFont(ofSize: 68)
            searchField.textColor = UIColor.white
            searchField.backgroundColor = UIColor.clear
            searchField.textAlignment = .center
            searchField.tag = Tag.make(5)
            self.view.addSubview(searchField)
            searchField.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.equalTo(0)
                make.bottom.equalTo(footView.snp.top)
            }
        }

        //顶部图片
        refreshHeadImage(offsetHead: 0, offsetFoot: 0, reloadImage: true)
    }

    func refreshHeadImage(offsetHead: CGFloat, offsetFoot: CGFloat, reloadImage: Bool = false) {
        if let tryModel = self.model {
            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = self.view.viewWithTag(Tag.make(6)) as? UIImageView {
                imgView.snp.removeConstraints()
                imgViewReal = imgView
            } else {
                let imgView = UIImageView()
                imgView.layer.masksToBounds = true
                imgView.tag = Tag.make(6)
                imgView.backgroundColor = UIColor(valueRGB: 0x222222)
                imgView.contentMode = .scaleAspectFill
                self.view.addSubview(imgView)
                self.view.sendSubview(toBack: imgView)
                imgViewReal = imgView
            }
            imgViewReal.snp.makeConstraints {
                (make) -> Void in
                make.left.right.equalTo(0)
                make.top.equalTo(min(0, -offsetHead))
                make.height.equalTo(tryModel.headImageHeight()
                    + max(0, -offsetHead) + max(0, -tableView.contentInset.bottom - offsetFoot)
                )
            }

            if reloadImage {
                imgViewReal.image = model.image
            }
        }
    }

    func closeClicked() {
        //键盘收起
        returnMark = true
        Function.HideKeyboard()

        self.dismiss(animated: true) {
            [weak self] () in
            
        }
    }

    func editFrameClicked(recognizer: UIGestureRecognizer) {
        if let tryTag = recognizer.view?.tag {
            switch tryTag {
            case Tag.make(3):
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
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)

                //底部视图
                if let view = self.view.viewWithTag(Tag.make(2)) {
                    view.snp.removeConstraints()
                    view.snp.makeConstraints() {
                        (make) in
                        make.bottom.equalTo(-tryHeight)
                        make.left.right.equalTo(0)
                        make.height.equalTo(89)
                    }
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
        if textField.tag == Tag.make(4) {
            print("此处应该提交")
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    var returnMark = false
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //失去焦点
        if returnMark {
            textField.superview?.layer.borderWidth = 0
            textField.superview?.layer.borderColor = UIColor.clear.cgColor
        }
        return returnMark
    }
}

