

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
        switch title {
        case "加入":
            tableViewRegiste.isHidden = false
            tableViewLogin.isHidden = true
            break
        case "登录":
            tableViewLogin.isHidden = false
            tableViewRegiste.isHidden = true
            break
        default:
            break
        }
    }

    //MARK:- UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //获得焦点
        print("获得焦点")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //键盘关闭
        print("键盘关闭")
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //失去焦点
        print("失去焦点")
        return true
    }
}

