

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        addControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addControls() {
        //addHeadView
        if let _ = self.view.viewWithTag(Tag.make(0)) as? MainHeadView {

        } else {
            let view = MainHeadView(self)
            view.layer.masksToBounds = false
            view.tag = Tag.make(0)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.equalTo(0)
                make.height.equalTo(69)
            }
        }

        //addCollectionView
        if let _ = self.view.viewWithTag(Tag.make(1)) as? MainCollectinView {

        } else {
            let view = MainCollectinView(self)
            view.tag = Tag.make(1)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(69)
                make.left.right.bottom.equalTo(0)
            }
        }
    }
}

