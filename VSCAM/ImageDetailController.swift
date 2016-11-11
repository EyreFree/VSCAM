

import UIKit
import MJRefresh

class ImageDetailController: UIViewController {

    var tableView: ImageDetailTableView!
    var model: ImageDetailModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(pid: Int, imageBrief: PhotoObject? = nil) {
        super.init(nibName: nil, bundle: nil)

        addModel()
        model?.pid = pid
        model?.imageBrief = imageBrief
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addControls()
    }

    func addModel() {
        model = ImageDetailModel()
    }

    func addControls() {
        //addHeadView
        if let _ = self.view.viewWithTag(Tag.make(0)) as? ImageDetailHeadView {

        } else {
            let view = ImageDetailHeadView(self)
            view.layer.masksToBounds = false
            view.tag = Tag.make(0)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.equalTo(0)
                make.height.equalTo(55)
            }
        }

        //addCollectionView
        if let _ = self.view.viewWithTag(Tag.make(1)) as? ImageDetailTableView {

        } else {
            let view = ImageDetailTableView(self)
            view.tag = Tag.make(1)
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.view.sendSubview(toBack: view)
            self.tableView = view
        }

        //顶部图片
        refreshHeadImage(reloadImage: true)
    }

    func refreshHeadImage(offset: CGFloat = 0, reloadImage: Bool = false) {
        if let tryModel = self.model {
            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = self.view.viewWithTag(Tag.make(2)) as? UIImageView {
                imgView.snp.removeConstraints()
                imgViewReal = imgView
            } else {
                let imgView = UIImageView()
                imgView.tag = Tag.make(2)
                imgView.backgroundColor = UIColor(valueRGB: 0x222222)
                imgView.contentMode = .scaleAspectFill
                self.view.addSubview(imgView)
                self.view.sendSubview(toBack: imgView)
                imgViewReal = imgView
            }
            imgViewReal.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.equalTo(0)
                make.height.equalTo(max(0, tryModel.headImageHeight() - offset))
            }

            //半透明黑色遮罩
            var imgMaskViewReal: UIView!
            if let imgMaskView = imgViewReal.viewWithTag(Tag.make(-1)) {
                imgMaskViewReal = imgMaskView
            } else {
                let imgMaskView = UIView()
                imgMaskView.tag = Tag.make(-1)
                imgMaskView.backgroundColor = UIColor.black
                imgViewReal.addSubview(imgMaskView)
                imgMaskView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.left.right.bottom.equalTo(0)
                }
                imgMaskViewReal = imgMaskView
            }
            if offset > 0 {
                imgMaskViewReal.isHidden = false
                imgMaskViewReal.alpha = offset / tryModel.headImageHeight()
            } else {
                imgMaskViewReal.isHidden = true
            }

            if reloadImage {
                imgViewReal.image = UIImage.placeholderTransparent
                var imageUrlString: String?
                if let tryWbpid = (tryModel.imageBrief?.wbpid ?? tryModel.imageDetail?.wbpid) {
                    if tryWbpid.isEmpty == false {
                        imageUrlString = NetworkURL.imageWBBig + tryWbpid
                    } else if let tryOrigin = (tryModel.imageBrief?.origin ?? tryModel.imageDetail?.origin) {
                        imageUrlString = NetworkURL.imageOriginBig.replace(string: "{origin}", with: tryOrigin)
                    }
                }
                if let tryUrlString = imageUrlString {
                    imgViewReal.setImageWithURLString(UrlString: tryUrlString)
                }
            }
        }
    }

    func backClicked() {
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }

    func shareClicked() {
        if let tryPID = (model.imageBrief?.pid ?? model.imageDetail?.pid),
            let tryTitle = (model.imageBrief?.text ?? model.imageDetail?.text) {
            let webUrl = NetworkURL.webImageDetail.replace(string: "{pid}", with: "\(tryPID)")
            Function.openShareView(controller: self, title: "[VSCAM]\(tryTitle)", url: webUrl)
        }
    }
}

