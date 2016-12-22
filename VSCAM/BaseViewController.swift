

import UIKit
import RxSwift

//UIViewController基类
class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //顶部自动间隔去掉，腊鸡
        self.automaticallyAdjustsScrollViewInsets = false

    }

    //将 Push 后的 VC 的导航栏返回按钮标题设为“”
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

