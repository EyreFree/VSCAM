

import UIKit
import Alamofire

//MARK:- 网络接口
class NetworkAPI {

    static let sharedInstance = NetworkAPI()

    // MARK:- 基地址
    let baseUrl = NetworkURL.baseUrl

    var manager: SessionManager!            //普通的
    private var managerUnlimited: SessionManager!   //长时间的
    init() {
        var customHeader = SessionManager.defaultHTTPHeaders
        customHeader.updateValue("https://vscam.co/", forKey: "referer")

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = customHeader
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 2 * 60    //2分钟
        if let tryCookies = NetworkCache.cookies {
            for cookie in tryCookies {
                configuration.httpCookieStorage?.setCookie(cookie)
            }
        }
        manager = SessionManager(configuration: configuration)

        let configurationUnlimited = URLSessionConfiguration.default
        configurationUnlimited.httpAdditionalHeaders = customHeader
        configurationUnlimited.requestCachePolicy = .reloadIgnoringLocalCacheData
        configurationUnlimited.timeoutIntervalForRequest = 20 * 60 //20 分钟
        if let tryCookies = NetworkCache.cookies {
            for cookie in tryCookies {
                configurationUnlimited.httpCookieStorage?.setCookie(cookie)
            }
        }
        managerUnlimited = SessionManager(configuration: configurationUnlimited)
    }

    func refreshManagerUnlimitedCookies() {
        if let tryCookies = NetworkCache.cookies {
            for cookie in tryCookies {
                managerUnlimited.session.configuration.httpCookieStorage?.setCookie(cookie)
            }
        }
    }

    //MARK:- 通用处理
    //检测是否错误
    func checkError(_ response: HTTPURLResponse?, error: Error?) -> String? {
        if let errorString = error?.localizedDescription {
            return "\(errorString))"
        }
        if 200 != response?.statusCode {
            return "请求失败(\(response?.statusCode ?? 0))"
        }
        return nil
    }

    //分析返回结果
    func resultAnalysis(_ response: HTTPURLResponse?, data: Data?, error: Error?) -> (String?, AnyObject?) {
        //printData(data)
        if let errorString = self.checkError(response, error: error) {
            return (errorString, nil)
        } else {
            if let array = NSData.data2Json(data) as? NSArray {
                return (nil, array)
            } else if let dict = NSData.data2Json(data) as? NSDictionary {
                if let tryErrorMessage = NetworkError(dict: dict) {
                    return (tryErrorMessage.description, nil)
                } else {
                    return (nil, dict)
                }
            }
        }
        if let tryData = data {
            if let resultString = NSString(data: tryData, encoding: String.Encoding.utf8.rawValue) as? String {
                if resultString == "true" {
                    return (nil, nil)
                } else if resultString == "false" {
                    return ("操作失败", nil)
                }
            }
        }
        return ("数据异常", nil)
    }

    //拼 JSON 数组
    func arrayToString(array: [AnyObject], brackets: Bool = true) -> String {
        var result = ""
        for (index, data) in array.enumerated() {
            if 0 != index {
                result += ","
            }
            result += "\(data)"
        }
        return brackets ? "[" + result + "]" : result
    }

    //打印 Data 内容
    func printData(_ data: Data?) {
        if let tryData = data {
            print(String(describing: NSString(data: tryData, encoding: String.Encoding.utf8.rawValue)))
        } else {
            print("PrintData: 空数据")
        }
    }

    //MARK:- 接口
    //图片列表 - 首页 or 用户页
    //n:20          //数量 默认:30
    //s:1300000000  //时间戳 默认:最新 筛选这个时间之前
    //u:6           //用户id 默认:不存在 按照用户 id 筛选
    func imageList(n: Int = Define.pageCount, s: Int64? = nil, u: Int? = nil, finish: @escaping (ImageListObject?, String?) -> Void) {
        var parameters: [String : Any] = ["n": n]
        if let tryS = s {
            parameters.updateValue(tryS, forKey: "s")
        }
        if let tryU = u {
            parameters.updateValue(tryU, forKey: "u")
        }
        manager.request(baseUrl + NetworkURL.imageList, method: .get, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                if tryErrorString == "数据异常" {
                    finish(ImageListObject(), nil)
                    return
                }
                finish(nil, tryErrorString)
            } else if let tryObject = ImageListObject(result.1) {
                finish(tryObject, nil)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }

    //图片详情
    func imageDetail(id: Int, finish: @escaping (PhotoDetailObject?, String?) -> Void) {
        let parameters: [String : Any] = ["id": id]
        manager.request(baseUrl + NetworkURL.imageDetail, method: .get, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                finish(nil, tryErrorString)
            } else if let tryObject = PhotoDetailObject(result.1) {
                finish(tryObject, nil)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }

    //获取个人信息
    //根据 uid 获取用户信息
    func userInfoList(uids: [Int], finish: @escaping ([UserInfoObject]?, String?) -> Void) {
        let uidsString = arrayToString(array: uids as [AnyObject], brackets: false)
        manager.request(baseUrl + NetworkURL.userInfoList + uidsString, method: .get).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                finish(nil, tryErrorString)
            } else if let tryList = result.1 as? NSArray {
                var objectList = [UserInfoObject]()
                for userData in tryList {
                    if let tryObject = UserInfoObject(userData) {
                        objectList.append(tryObject)
                    }
                }
                finish(objectList, nil)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }

    //个人信息详情
    func userInfoDetail(name: String, finish: @escaping (UserInfoObject?, String?) -> Void) {
        let parameters: [String : Any] = ["name": name]
        manager.request(baseUrl + NetworkURL.userInfoDetail, method: .get, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                finish(nil, tryErrorString)
            } else if let tryObject = UserInfoObject((result.1 as? NSArray)?.firstObject) {
                finish(tryObject, nil)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }

    //获取登录者信息
    func userSelfInfo(finish: @escaping (UserSelfInfoObject?, String?) -> Void) {
        manager.request((baseUrl + NetworkURL.userInfoList).replace(string: "&uid=", with: ""), method: .get).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                finish(nil, tryErrorString)
            } else if let tryObject = UserSelfInfoObject(result.1) {
                finish(tryObject, nil)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }

    //登录
    func login(id: String, password: String, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["id": id, "password": password]
        manager.request(baseUrl + NetworkURL.login, method: .post, parameters: parameters).response {
            (response) in
            NetworkCache.saveCookies()
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //登出
    func logout(finish: @escaping (String?) -> Void) {
        let rand = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        manager.request(baseUrl + NetworkURL.logout + "\(rand)", method: .get).response {
            (response) in
            NetworkCache.saveCookies()
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //注册
    func registe(name: String, mail: String, password: String, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["name": name, "mail": mail, "password": password]
        manager.request(baseUrl + NetworkURL.registe, method: .post, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //修改个人信息
    func change(des: String, url: String, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["des": des, "url": url]
        manager.request(baseUrl + NetworkURL.change, method: .post, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //删除头像
    func avatarDelete(finish: @escaping (String?) -> Void) {
        manager.request(baseUrl + NetworkURL.avatarDelete, method: .get).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //修改头像
    func avatarSet(avatar: UIImage, finish: @escaping (String?) -> Void) {
        if let tryAvatarData = UIImageJPEGRepresentation(avatar, 1) {
            refreshManagerUnlimitedCookies()
            managerUnlimited.upload(multipartFormData: {
                (multipartFormData) in
                multipartFormData.append(tryAvatarData, withName: "avatar", fileName: "avatar.jpg", mimeType: "image/jpeg")
            }, to: baseUrl + NetworkURL.avatarSet, encodingCompletion: {
                (encodingResult) in
                switch encodingResult {
                case .success(request: let uploadRequest, streamingFromDisk: _, streamFileURL: _):
                    uploadRequest.response(completionHandler: {
                        (response) in
                        let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
                        finish(result.0)
                    })
                    break
                case .failure(let encodingError):
                    finish(encodingError.localizedDescription)
                    break
                }
            })
        } else {
            finish("图片编码失败")
        }
    }

    //上传图片
    func upload(pp: Data, progress: @escaping (Double) -> Void, finish: @escaping (PhotoUploadObject?, String?) -> Void) {
        refreshManagerUnlimitedCookies()
        managerUnlimited.upload(multipartFormData: {
            (multipartFormData) in
            multipartFormData.append(pp, withName: "pp", fileName: "pp.jpg", mimeType: "image/jpeg")
        }, to: baseUrl + NetworkURL.upload, encodingCompletion: {
            (encodingResult) in
            switch encodingResult {
            case .success(request: let uploadRequest, streamingFromDisk: _, streamFileURL: _):
                uploadRequest.uploadProgress(closure: { (value) in
                    progress(value.fractionCompleted)
                }).response(completionHandler: {
                    (response) in
                    let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
                    finish(PhotoUploadObject(result.1), result.0)
                })
                break
            case .failure(let encodingError):
                finish(nil, encodingError.localizedDescription)
                break
            }
        })
    }

    //登录
    func delete(pid: Int, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["pid": pid]
        manager.request(baseUrl + NetworkURL.delete, method: .post, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //发布图片
    func release(pid: Int, text: String, preset: String, exif: String, gps: String, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["pid": pid, "text": text, "preset": preset, "state": 1, "exif": exif, "gps": gps]
        manager.request(baseUrl + NetworkURL.release, method: .post, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }

    //举报图片
    func report(pid: Int, text: String?, finish: @escaping (String?) -> Void) {
        let parameters: [String : Any] = ["pid": pid, "text": text ?? ""]
        manager.request(baseUrl + NetworkURL.report, method: .post, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            finish(result.0)
        }
    }
}

