

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

        collectionView.mj_header.beginRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Variable.listNeedRefreshMain == true {
            //如果需要，刷新图片列表和登录用户信息

            Variable.listNeedRefreshMain = false
            Variable.loginNeedRefreshMain = false

            collectionView.mj_header.beginRefreshing()
        } else if Variable.loginNeedRefreshMain == true {
            //如果需要，刷新登录用户信息

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
                    trySelf.refreshUserInfo()
                    trySelf.refreshImageList()
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

    private var refreshUserInfoMark = true
    func refreshUserInfo() {
        if refreshUserInfoMark {
            refreshUserInfoMark = false

            NetworkAPI.sharedInstance.userSelfInfo() {
                [weak self] (userInfo, errorString) in
                if let trySelf = self {
                    if let tryErrorString = errorString {
                        print("用户信息加载失败: \(tryErrorString)")
                        if "尚未登录" == tryErrorString {
                            if let tryID = Variable.lastLoginUser, let tryPWD = Variable.lastLoginPWD {
                                //尝试重新登录
                                NetworkAPI.sharedInstance.login(id: tryID, password: tryPWD) {
                                    [weak self] (errorString) in
                                    if let trySelf = self {
                                        if let tryErrorString = errorString {
                                            print("重新登录失败: \(tryErrorString)")

                                            //清除旧的登录信息
                                            Variable.loginUserInfo = nil
                                            NetworkCache.cookies = nil

                                            if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? MainHeadView {
                                                headView.refreshAvatar()
                                            }
                                        } else {
                                            trySelf.refreshUserInfo()
                                        }
                                    }
                                }
                            } else {
                                //清除旧的登录信息
                                Variable.loginUserInfo = nil
                                NetworkCache.cookies = nil

                                if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? MainHeadView {
                                    headView.refreshAvatar()
                                }
                            }
                        }
                    } else if let tryUserInfo = userInfo {
                        Variable.loginUserInfo = tryUserInfo

                        if let headView = trySelf.view.viewWithTag(Tag.make(0)) as? MainHeadView {
                            headView.refreshAvatar()
                        }
                    }
                    trySelf.refreshUserInfoMark = true
                }
            }
        }
    }

    private var refreshImageListMark = true
    func refreshImageList() {
        if refreshImageListMark {
            refreshImageListMark = false

            self.collectionView.mj_footer.endRefreshingWithNoMoreData()
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
                    trySelf.refreshImageListMark = true
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
        if Variable.loginUserInfo == nil {
            Function.MessageBox(self, title: "提示", content: "请先登录", type: .info)
        } else {
            if nil == imagePicker {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = false
                imagePicker = picker
            }
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    //MARK:- UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let tryUrl = info[UIImagePickerControllerReferenceURL] as? URL {
            if let tryFetchResult = PHAsset.fetchAssets(withALAssetURLs: [tryUrl], options: nil).firstObject {
                PHImageManager.default().requestImageData(for: tryFetchResult, options: nil, resultHandler: {
                    [weak self] (imageData, dataUTI, orientation, info) in
                    if let trySelf = self {
                        if let tryImageData = imageData {
                            if let tryCIImage = CIImage(data: tryImageData) {
                                //检测 VSCO 编辑
                                var preset: String?
                                let targetExifList = [
                                    (tryCIImage.properties["{Exif}"] as? NSDictionary)?["UserComment"] ,
                                    (tryCIImage.properties["{TIFF}"] as? NSDictionary)?["ImageDescription"]
                                ]
                                for subExifString in targetExifList {
                                    if let trySubExifString = subExifString as? String {
                                        if true == trySubExifString.hasSubString(string: "VSCO") {
                                            preset = ""
                                            let stringArray = trySubExifString.components(separatedBy: "with")
                                            for subString in stringArray {
                                                if subString.hasSubString(string: "preset") {
                                                    let stringInArray = subString.components(separatedBy: "preset")
                                                    preset = stringInArray.first ?? ""
                                                    break
                                                }
                                            }
                                        }
                                    }
                                    if preset?.isEmpty == false {
                                        break
                                    }
                                }
                                //检测 Apple 拍摄
                                if preset == nil {
                                    for value in tryCIImage.properties {
                                        if let tryDict = value.value as? NSDictionary {
                                            for valueIn in tryDict {
                                                if let tryString = valueIn.value as? String {
                                                    if tryString.hasSubString(string: "Apple") {
                                                        preset = ""
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                if let tryPreset = preset {
                                    trySelf.present(
                                        PublishController(imageData: tryImageData, preset: tryPreset.clean().uppercased()),
                                        animated: true
                                    )
                                    return
                                }
                                Function.MessageBox(trySelf, title: "提示", content: "请选择使用 iPhone 拍摄的照片或其它经过处理的图片", type: .info)
                                return
                            }
                        }
                        Function.MessageBox(trySelf, title: "获取图片失败", content: "所选图片无效")
                    }
                })
                imagePicker.dismiss(animated: true, completion: nil)
                return
            }
        }
        Function.MessageBox(self, title: "获取图片失败", content: "所选图片无效")
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

