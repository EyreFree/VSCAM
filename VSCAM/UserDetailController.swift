

import UIKit
import MJRefresh

class UserDetailController: BaseViewController {

    var collectionView: UserDetailCollectinView!
    var model: UserDetailModel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(userData: UserObject) {
        super.init(nibName: nil, bundle: nil)

        addModel()
        model?.userData = userData
        model?.refreshModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        addControls()

        refreshUserData()
        collectionView?.mj_header?.beginRefreshing()
    }

    func addModel() {
        model = UserDetailModel()
    }

    func addControls() {
        //buttons
        let isSelf = model?.isSelf ?? false

        if let _ = self.view.viewWithTag(Tag.make(4)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_返回_黑")
            view.tag = Tag.make(4)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(UserDetailController.backClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        if let view = self.view.viewWithTag(Tag.make(5)) as? UIImageView {
            view.isHidden = isSelf
        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_更多_黑")
            view.tag = Tag.make(5)
            view.isUserInteractionEnabled = true
            view.isHidden = isSelf
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(UserDetailController.shareClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        if let view = self.view.viewWithTag(Tag.make(6)) as? UIImageView {
            view.isHidden = !isSelf
        } else {
            let view = UIImageView()
            view.contentMode = .center
            view.image = UIImage(named: "按钮_设置_黑")
            view.tag = Tag.make(6)
            view.isUserInteractionEnabled = true
            view.isHidden = !isSelf
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(UserDetailController.settingClicked))
            )
            self.view.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(55)
            }
        }

        //addHeadView
        if let _ = self.view.viewWithTag(Tag.make(0)) as? UserDetailHeadView {

        } else {
            let view = UserDetailHeadView(self)
            view.layer.masksToBounds = false
            view.isUserInteractionEnabled = false
            view.tag = Tag.make(0)
            self.view.addSubview(view)
            self.view.sendSubview(toBack: view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.equalTo(0)
                make.height.equalTo(model.hasAvatar ? 256 : 186)
            }
        }

        //addCollectionView
        if let _ = self.view.viewWithTag(Tag.make(1)) as? UserDetailCollectinView {

        } else {
            let view = UserDetailCollectinView(self)
            view.tag = Tag.make(1)
            self.view.addSubview(view)
            self.view.sendSubview(toBack: view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            self.collectionView = view

            let customHeader = MJRefreshNormalHeader() {
                [weak self] in
                if let trySelf = self {
                    if let tryUID = trySelf.model?.userData?.uid {
                        trySelf.collectionView.mj_footer.endRefreshingWithNoMoreData()
                        NetworkAPI.sharedInstance.imageList(u: tryUID) {
                            [weak self] (imagelist, errorString) in
                            if let trySelf = self {
                                if let tryErrorString = errorString {
                                    Function.MessageBox(trySelf, title: "图片列表刷新失败", content: tryErrorString)
                                } else if let tryImageList = imagelist {
                                    trySelf.model?.imageList = tryImageList

                                    trySelf.collectionView.addReuseIdentifier()
                                    trySelf.collectionView.reloadData()
                                }
                                if let tryCount = imagelist?.grids?.count {
                                    if tryCount >= Define.pageCount {
                                        trySelf.collectionView.mj_footer.resetNoMoreData()
                                    }
                                }
                                trySelf.collectionView.mj_header.endRefreshing()
                            }
                        }
                    }
                }
            }
            customHeader?.lastUpdatedTimeLabel.isHidden = true
            customHeader?.stateLabel.isHidden = true
            customHeader?.isAutomaticallyChangeAlpha = true
            view.mj_header = customHeader

            let customFooter = MJRefreshBackNormalFooter() {
                [weak self] in
                if let trySelf = self {
                    if let tryUID = trySelf.model?.userData?.uid {
                        if let tryDate = trySelf.model?.imageList?.grids?.last?.unix {
                            NetworkAPI.sharedInstance.imageList(s: tryDate, u: tryUID) {
                                [weak self] (imagelist, errorString) in
                                if let trySelf = self {
                                    if let tryErrorString = errorString {
                                        Function.MessageBox(trySelf, title: "图片列表加载失败", content: tryErrorString)
                                    } else if let tryImageList = imagelist {
                                        trySelf.model?.imageList?.append(newObject: tryImageList)

                                        trySelf.collectionView.addReuseIdentifier()
                                        trySelf.collectionView.reloadData()
                                    }
                                    if let tryCount = imagelist?.grids?.count {
                                        if tryCount < Define.pageCount {
                                            trySelf.collectionView.mj_footer.endRefreshingWithNoMoreData()
                                            return
                                        }
                                    }
                                    trySelf.collectionView.mj_footer.endRefreshing()
                                }
                            }
                        }
                    }
                }
            }
            customFooter?.stateLabel.isHidden = true
            view.mj_footer = customFooter
        }
    }

    func refreshHeadView(offset: CGFloat) {
        let marginHead = (model.hasAvatar ? 256 : 186).f()
        let finalOffset = offset + marginHead

        var alpha = (marginHead - finalOffset) / marginHead
        if alpha < 0 {
            alpha = 0
        } else if alpha > 1 {
            alpha = 1
        }

        if let headView = self.view.viewWithTag(Tag.make(0)) as? UserDetailHeadView {
            headView.alpha = alpha
        }

        if let view = self.view.viewWithTag(Tag.make(4)) as? UIImageView {
            view.image = UIImage(named: alpha <= 0 ? "按钮_返回_白" : "按钮_返回_黑")
        }

        if let view = self.view.viewWithTag(Tag.make(5)) as? UIImageView {
            view.image = UIImage(named: alpha <= 0 ? "按钮_更多_白" : "按钮_更多_黑")
        }

        if let view = self.view.viewWithTag(Tag.make(6)) as? UIImageView {
            view.image = UIImage(named: alpha <= 0 ? "按钮_设置_白" : "按钮_设置_黑")
        }
    }

    func refreshUserData() {
        if let tryUID = model.userData?.uid ?? model.userDetailData?.uid {
            NetworkAPI.sharedInstance.userInfoList(uids: [tryUID]) {
                [weak self] (userInfoList, errorString) in
                if let trySelf = self {
                    if let tryErrorString = errorString {
                        print("用户信息加载失败: \(tryErrorString)")
                    } else if let tryUserInfoList = userInfoList {
                        if tryUserInfoList.count > 0 {
                            trySelf.model?.userDetailData = tryUserInfoList[0]

                            if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? UserDetailHeadView {
                                headView.refreshData()
                            }
                        }
                    }
                }
            }
        }
    }

    func clickImageAt(index: Int) {
        if let tryImages = model?.imageList?.grids {
            MainNavigationController.sharedInstance.pushViewController(
                ImageDetailController(imageBrief: tryImages[index]), animated: true
            )
        }
    }

    func backClicked() {
        MainNavigationController.sharedInstance.popViewController(animated: true)
    }
    
    func shareClicked() {
        if let tryName = (model.userData?.name ?? model.userDetailData?.name) {
            let webUrl = NetworkURL.userDetailPage.replace(string: "{name}", with: tryName)
            Function.openShareView(controller: self, title: "[VSCAM]\(tryName)", url: webUrl)
        }
    }
    
    func settingClicked() {
        
    }
}

