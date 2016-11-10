

import UIKit
import Alamofire

//MARK:- 网络接口
class NetworkAPI {

    static let sharedInstance = NetworkAPI()

    // MARK:- 基地址
    let baseUrl = NetworkURL.baseUrl

    private var manager: SessionManager!            //普通的
    private var managerUnlimited: SessionManager!   //长时间的
    init() {
        var customHeader = SessionManager.defaultHTTPHeaders
        customHeader.updateValue("1200", forKey: "TT-Type")

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = customHeader
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 2 * 60    //2分钟
        manager = SessionManager(configuration: configuration)

        let configurationUnlimited = URLSessionConfiguration.default
        configurationUnlimited.httpAdditionalHeaders = customHeader
        configurationUnlimited.requestCachePolicy = .reloadIgnoringLocalCacheData
        configurationUnlimited.timeoutIntervalForRequest = 20 * 60 //20 分钟
        managerUnlimited = SessionManager(configuration: configurationUnlimited)
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
        return ("数据异常", nil)
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
    func imageList(n: Int = 30, s: Int64? = nil, u: Int? = nil, finish: @escaping (ImageListObject?, String?) -> Void) {
        var parameters: [String : Any] = ["n": n]
        if let tryS = s {
            parameters.updateValue(tryS, forKey: "s")
        }
        if let tryU = u {
            parameters.updateValue(tryU, forKey: "u")
        }
        manager.request(baseUrl + NetworkURL.imageList, method: HTTPMethod.get, parameters: parameters).response {
            (response) in
            let result = self.resultAnalysis(response.response, data: response.data, error: response.error)
            if let tryErrorString = result.0 {
                finish(nil, tryErrorString)
            } else if let tryObject = ImageListObject(result.1) {
                finish(tryObject, result.0)
            } else {
                finish(nil, "数据格式错误")
            }
        }
    }
}

