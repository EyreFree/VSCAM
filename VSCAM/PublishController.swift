

import UIKit
import MJRefresh
import LFRoundProgressView

class PublishController: BaseViewController, UITextFieldDelegate {

    var tableView: PublishTableView!
    var model: PublishModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(imageData: Data, preset: String) {
        super.init(nibName: nil, bundle: nil)

        addModel()
        model?.preset = preset
        model?.imageData = imageData
        model?.image = UIImage(data: model.imageData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addControls()

        //
        addKeyboardObserver()

        //上传图片
        NetworkAPI.sharedInstance.upload(pp: model.imageData, progress: {
            [weak self] (progress) in
            if let trySelf = self {
                if let view = trySelf.view.viewWithTag(Tag.make(-1)) as? LFRoundProgressView {
                    view.progress = min(Float(progress), 0.99)
                }
            }
        }) {
            [weak self] (photoData, errorString) in
            if let trySelf = self {
                if let tryErrorString = errorString {
                    trySelf.model.uploadError = tryErrorString
                    Function.MessageBox(trySelf, title: "上传失败", content: tryErrorString)
                } else {
                    trySelf.model.uploadResult = photoData
                    trySelf.model.uploadFinished = true
                    if let view = trySelf.view.viewWithTag(Tag.make(-1)) as? LFRoundProgressView {
                        view.progress = 1
                        view.isHidden = true
                    }
                }
            }
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
        //进度条
        if let _ = self.view.viewWithTag(Tag.make(-1)) as? LFRoundProgressView {

        } else {
            let view = LFRoundProgressView(
                frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 39, height: 39))
            )
            view.annularLineCapStyle = CGLineCap.round
            view.annularLineWith = 4
            view.percentLabelFont = UIFont.boldSystemFont(ofSize: 10)
            view.percentLabelTextColor = UIColor.white
            view.tag = Tag.make(-1)
            view.isUserInteractionEnabled = false
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(8)
                make.width.height.equalTo(39)
            }
        }

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
            let view = UIView(
                frame: CGRect(
                    x: 0, y: CGSize.screen().height - 89,
                    width: CGSize.screen().width, height: 89
                )
            )
            view.backgroundColor = UIColor.white
            view.tag = Tag.make(2)
            self.view.addSubview(view)
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
            searchField.text = model.preset?.isEmpty == true ? "-" : model.preset
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
        tableView.scrollViewDidScroll(tableView)
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

    func submitClicked(textField: UITextField) {
        if let tryErrorString = self.model.uploadError {
            Function.MessageBox(self, title: "发布失败", content: tryErrorString)
        } else if self.model.uploadFinished == false {
            Function.MessageBox(self, title: "提示", content: "图片正在上传", theme: .warning)
        } else if textField.text?.clean().isEmpty != false {
            Function.MessageBox(self, title: "提示", content: "图片描述不能为空", theme: .warning)
        } else {
            if let tryPID = model.uploadResult?.pid, let tryText = textField.text?.clean(), let tryPreset = model.preset, let tryGPS = model.uploadResult?.gps, let tryExif = model.uploadResult?.exif {
                LoadingView.sharedInstance.show(controller: self)
                NetworkAPI.sharedInstance.release(pid: tryPID, text: tryText, preset: tryPreset, exif: tryExif, gps: tryGPS) {
                    [weak self] (errorString) in
                    if let trySelf = self {
                        if let tryErrorString = errorString {
                            Function.MessageBox(trySelf, title: "发布失败", content: tryErrorString)
                            LoadingView.sharedInstance.hide()
                        } else {
                            //主页刷新
                            Variable.listNeedRefreshMain = true

                            LoadingView.sharedInstance.hide()

                            //关闭当前页
                            trySelf.closeClicked()
                        }
                    }
                }
            }
        }
    }

    //键盘出现
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let tryHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tryHeight, right: 0)
                //底部视图
                UIView.animate(withDuration: 0.28) {
                    [weak self] () in
                    if let trySelf = self {
                        if let view = trySelf.view.viewWithTag(Tag.make(2)) {
                            view.frame = CGRect(
                                x: 0, y: CGSize.screen().height - 89 - tryHeight,
                                width: CGSize.screen().width, height: 89
                            )
                        }
                    }
                }
                //
                tableView.scrollViewDidScroll(tableView)
            }
        }
    }

    //键盘消失
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //底部视图
        UIView.animate(withDuration: 0.28) {
            [weak self] () in
            if let trySelf = self {
                if let view = trySelf.view.viewWithTag(Tag.make(2)) {
                    view.frame = CGRect(
                        x: 0, y: CGSize.screen().height - 89,
                        width: CGSize.screen().width, height: 89
                    )
                }
            }
        }
        //
        tableView.scrollViewDidScroll(tableView)
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
            submitClicked(textField: textField)
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

