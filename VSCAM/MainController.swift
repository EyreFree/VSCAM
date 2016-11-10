

import UIKit
import MJRefresh

class MainController: UIViewController {

    var collectionView: MainCollectinView!
    var model: MainModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        addModel()
        addControls()

        collectionView?.mj_header?.beginRefreshing()
    }

    func addModel() {
        model = MainModel()
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
            self.collectionView = view

            view.mj_header = MJRefreshNormalHeader() {
                [weak self] in
                if let _ = self {
                    NetworkAPI.sharedInstance.imageList() {
                        [weak self] (imagelist, errorString) in
                        if let trySelf = self {
                            if let tryErrorString = errorString {
                                Function.MessageBox(trySelf, title: "图片列表刷新失败", content: tryErrorString)
                            } else if let tryImageList = imagelist {
                                trySelf.model?.imageList = tryImageList

                                trySelf.collectionView.addReuseIdentifier()
                                trySelf.collectionView.reloadData()
                            }
                            trySelf.collectionView.mj_header.endRefreshing()
                        }
                    }
                }
            }
            view.mj_header.isAutomaticallyChangeAlpha = true

            view.mj_footer = MJRefreshBackNormalFooter() {
                [weak self] in
                if let trySelf = self {
                    if let tryDate = trySelf.model?.imageList?.grids?.last?.unix {
                        NetworkAPI.sharedInstance.imageList(s: tryDate) {
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
                                    if tryCount < 30 {
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
    }
}

