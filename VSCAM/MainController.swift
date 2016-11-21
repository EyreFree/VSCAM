

import UIKit
import MJRefresh
import Photos

class MainController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var collectionView: MainCollectinView!
    var model: MainModel!

    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true

        addModel()
        addControls()

        collectionView?.mj_header?.beginRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //如果需要，刷新登录用户信息
        if Variable.loginNeedRefreshMain == true {
            Variable.loginNeedRefreshMain = false

            refreshUserInfo()
        }

        Function.setStatusBar(hidden: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Function.setStatusBar(hidden: true)
    }

    func addModel() {
        model = MainModel()
    }

    func addControls() {
        //addHeadView
        if let _ = self.view.viewWithTag(Tag.make(0)) as? MainHeadView {

        } else {
            let view = MainHeadView(self)
            view.isUserInteractionEnabled = true
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

            let customHeader = MJRefreshNormalHeader() {
                [weak self] in
                if let trySelf = self {
                    trySelf.collectionView.mj_footer.endRefreshingWithNoMoreData()
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
            customHeader?.lastUpdatedTimeLabel.isHidden = true
            customHeader?.stateLabel.isHidden = true
            customHeader?.isAutomaticallyChangeAlpha = true
            view.mj_header = customHeader

            let customFooter = MJRefreshBackNormalFooter() {
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
            //customFooter?.setTitle("Click or drag up to refresh", for: MJRefreshState.idle)
            //customFooter?.setTitle("Loading more ...", for: MJRefreshState.refreshing)
            //customFooter?.setTitle("No more data", for: MJRefreshState.noMoreData)
            customFooter?.stateLabel.isHidden = true
            view.mj_footer = customFooter
        }
    }
    
    func refreshUserInfo() {
        NetworkAPI.sharedInstance.userSelfInfo() {
            [weak self] (userInfo, errorString) in
            if let trySelf = self {
                if let tryErrorString = errorString {
                    print("用户信息加载失败: \(tryErrorString)")
                    if "尚未登录" == tryErrorString {
                        Variable.loginUserInfo = nil

                        if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? MainHeadView {
                            headView.refreshAvatar()
                        }
                    }
                } else if let tryUserInfo = userInfo {
                    Variable.loginUserInfo = tryUserInfo

                    if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? MainHeadView {
                        headView.refreshAvatar()
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

    func avatarClicked() {
        if let tryUserInfo = Variable.loginUserInfo {
            MainNavigationController.sharedInstance.pushViewController(
                UserDetailController(userData: tryUserInfo), animated: true
            )
        } else {
            MainNavigationController.sharedInstance.pushViewController(
                LoginRegisteController(), animated: true
            )
        }
    }

    func publishClicked() {
        if nil == imagePicker {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = false
            imagePicker = picker
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

    //MARK:- UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }

    private var pickerImage: UIImage!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickerImage = selectImage.copy() as? UIImage

            let url = info[UIImagePickerControllerReferenceURL]
            let fetchResult = PHAsset.fetchAssets(withALAssetURLs: [url as! URL], options: nil)
            let asset = fetchResult.firstObject

            PHImageManager.default().requestImageData(for: asset!, options: nil, resultHandler: {
                (imageData, dataUTI, orientation, info) in
                let ciImage = CIImage(data: imageData!)
                print(ciImage?.properties)
            })
        } else {
            Function.MessageBox(self, title: "获取图片失败", content: "所选图片无效")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

