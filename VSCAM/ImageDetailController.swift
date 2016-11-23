

import UIKit
import MJRefresh

class ImageDetailController: BaseViewController {

    var tableView: ImageDetailTableView!
    var model: ImageDetailModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(imageBrief: PhotoObject? = nil) {
        super.init(nibName: nil, bundle: nil)

        addModel()
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
        //buttons
        if let _ = self.view.viewWithTag(Tag.make(4)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_返回_白")
            view.tag = Tag.make(4)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(ImageDetailController.backClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        if let _ = self.view.viewWithTag(Tag.make(5)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_更多_白")
            view.tag = Tag.make(5)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(ImageDetailController.shareClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addTableView
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

        //底部图片
        refreshFootImage(offset: tableView.contentSize.height - CGSize.screen().height, reloadImage: true)

        //顶部图片
        refreshHeadImage(offset: 0, reloadImage: true)
    }

    func refreshHeadImage(offset: CGFloat, reloadImage: Bool = false) {
        if let tryModel = self.model {
            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = self.view.viewWithTag(Tag.make(2)) as? UIImageView {
                imgView.snp.removeConstraints()
                imgViewReal = imgView
            } else {
                let imgView = UIImageView()
                imgView.layer.masksToBounds = true
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
                    imgViewReal.setImageWithURLString(UrlString: tryUrlString) {
                        [weak self] (image) in
                        //保存获取的图片
                        if let trySelf = self {
                            trySelf.model?.image = image
                        }
                    }
                }
            }
        }
    }

    func refreshFootImage(offset: CGFloat, reloadImage: Bool = false) {
        if let tryModel = self.model {
            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = self.view.viewWithTag(Tag.make(0)) as? UIImageView {
                imgView.snp.removeConstraints()
                imgViewReal = imgView
            } else {
                let imgView = UIImageView(frame: CGRect.zero)
                imgView.layer.masksToBounds = true
                imgView.tag = Tag.make(0)
                imgView.backgroundColor = UIColor(valueRGB: 0x222222)
                imgView.contentMode = .scaleAspectFill
                self.view.addSubview(imgView)
                self.view.sendSubview(toBack: imgView)
                imgViewReal = imgView
            }

            if offset > 210 {
                imgViewReal.isHidden = true
            } else if offset > 70 {
                imgViewReal.isHidden = false
                imgViewReal.snp.makeConstraints {
                    (make) -> Void in
                    make.left.right.equalTo(0)
                    make.bottom.equalTo(offset - 70)
                    make.height.equalTo(140)
                }
            } else {
                imgViewReal.isHidden = false
                imgViewReal.snp.makeConstraints {
                    (make) -> Void in
                    make.bottom.left.right.equalTo(0)
                    make.height.equalTo(210 - offset)
                }
            }

            if reloadImage {
                imgViewReal.image = UIImage.placeholderTransparent
                var imageUrlString: String?
                if let tryGps = (tryModel.imageBrief?.gps ?? tryModel.imageDetail?.gps) {
                    if tryGps.isEmpty == false {
                        imageUrlString = NetworkURL.imageMap.replace(string: "{gps}", with: tryGps)
                    }
                }
                if let tryUrlString = imageUrlString {
                    imgViewReal.setImageWithURLString(UrlString: tryUrlString)
                } else {
                    imgViewReal.backgroundColor = UIColor.white
                }
            }
        }
    }

    func backClicked() {
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }

    func shareClicked() {
        if let tryLocalUID = Variable.loginUserInfo?.uid {
            if (model.imageBrief?.uid ?? model.imageDetail?.uid) == tryLocalUID {
                let actionSheetController = UIAlertController(
                    title: nil, message: nil, preferredStyle: .actionSheet
                )

                let cancelActionButton = UIAlertAction(title: "取消", style: .cancel) {
                    action -> Void in
                }
                actionSheetController.addAction(cancelActionButton)

                let actionButton1 = UIAlertAction(title: "分享", style: .default) {
                    [weak self] action -> Void in
                    if let strongSelf = self {
                        strongSelf.shareAction()
                    }
                }
                actionSheetController.addAction(actionButton1)

                let actionButton2 = UIAlertAction(title: "删除", style: .destructive) {
                    [weak self] action -> Void in
                    if let strongSelf = self {
                        strongSelf.deleteAction()
                    }
                }
                actionSheetController.addAction(actionButton2)

                //阻止 iPad Crash
                actionSheetController.popoverPresentationController?.sourceView = self.view
                actionSheetController.popoverPresentationController?.sourceRect = CGRect(
                    x: self.view.bounds.size.width / 2.0,
                    y: self.view.bounds.size.height / 2.0,
                    width: 1.0, height: 1.0
                )

                self.present(actionSheetController, animated: true, completion: nil)
                return
            }
        }

        shareAction()
    }

    func shareAction() {
        if let tryPID = (model.imageBrief?.pid ?? model.imageDetail?.pid),
            let tryTitle = (model.imageBrief?.text ?? model.imageDetail?.text) {
            let webUrl = NetworkURL.imageDetailPage.replace(string: "{pid}", with: "\(tryPID)")
            Function.openShareView(controller: self, title: "[VSCAM]\(tryTitle)", url: webUrl)
        }
    }

    func deleteAction() {
        if let tryPID = model.imageBrief?.pid ?? model.imageDetail?.pid {
            LoadingView.sharedInstance.show(controller: self)
            NetworkAPI.sharedInstance.delete(pid: tryPID) {
                [weak self] (errorString) in
                if let trySelf = self {
                    if let tryErrorString = errorString {
                        Function.MessageBox(trySelf, title: "图片删除失败", content: tryErrorString)
                        LoadingView.sharedInstance.hide()
                    } else {
                        //主页刷新
                        Variable.listNeedRefreshMain = true
                        //用户页刷新
                        for controller in MainNavigationController.sharedInstance.viewControllers {
                            if let tryController = controller as? UserDetailController {
                                tryController.model.needRefreshList = true
                            }
                        }
                        LoadingView.sharedInstance.hide()
                        MainNavigationController.sharedInstance.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func userClicked() {
        if let tryUser = model?.imageBrief?.user ?? model?.imageDetail?.user {
            MainNavigationController.sharedInstance.pushViewController(
                UserDetailController(userData: tryUser), animated: true
            )
        }
    }

    func imageClicked() {
        if let tryImage = self.model?.image {
            let photoObject = MJPhoto()
            photoObject.image = tryImage

            let imageBroeser = MJPhotoBrowser()
            imageBroeser.photos = [photoObject]
            imageBroeser.currentPhotoIndex = 0
            imageBroeser.show()
        }
    }
}

