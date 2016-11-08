

import UIKit
import Alamofire

//MARK:- 接口地址
class APIUrl {
    
}

//MARK:- 网络接口
class NetworkAPI {

    static let sharedInstance = NetworkAPI()

    // MARK:- 基地址
    let baseUrl = Define.baseUrl

    private var manager: Manager!
    private var managerUnlimited: Manager!
    init() {
        var customHeader = Manager.defaultHTTPHeaders
        customHeader.updateValue("1200", forKey: "TT-Type")

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = customHeader
        configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 2 * 60    //2分钟
        manager = Manager(configuration: configuration)

        let configurationUnlimited = NSURLSessionConfiguration.defaultSessionConfiguration()
        configurationUnlimited.HTTPAdditionalHeaders = customHeader
        configurationUnlimited.requestCachePolicy = .ReloadIgnoringLocalCacheData
        configurationUnlimited.timeoutIntervalForRequest = 20 * 60 //20 分钟
        managerUnlimited = Manager(configuration: configurationUnlimited)
    }

    //MARK:- 通用处理
    //检测是否错误
    func checkError(response: NSHTTPURLResponse?, error: NSError?) -> String? {
        if let errorCode = error?.code {
            return "\(error?.localizedDescription ?? "")(\(errorCode))"
        }
        if 200 != response?.statusCode {
            return "服务器状态异常(\(response?.statusCode ?? 0))"
        }
        return nil
    }

    //分析返回结果
    func resultAnalysis(response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> (String?, NSDictionary?, NSArray?, Bool) {
        if let errorString = self.checkError(response, error: error) {
            return(errorString, nil, nil, false)
        } else {
            if let array = NSData.data2Json(data) as? NSArray {
                return (nil, nil, array, false)
            } else if let dict = NSData.data2Json(data) as? NSDictionary {
                if let message = NetworkError(dict: dict) {
                    if message.isConfirm {
                        return (message.content, nil, nil, true)
                    }
                    return (message.content, nil, nil, false)
                } else {
                    return (nil, dict, nil, false)
                }
            }
        }
        return("数据异常", nil, nil, false)
    }

    //confirm询问
    func confirmAsk(content: String?, finish: () -> Void ) {
        let alert = UIAlertController(title: content ?? "未知的确认信息", message: nil, preferredStyle: .Alert)
        alert.addAction(
            UIAlertAction(title: "取消", style: .Cancel) {
                (action) -> Void in
                LoadingView.sharedInstance.hide()
            }
        )
        alert.addAction(
            UIAlertAction(title: "确认", style: .Default) {
                (action) -> Void in
                finish()
            }
        )
        MainTabBarController.sharedInstance.presentViewController(alert, animated: true, completion: nil)
    }

    //拼 JSON 数组
    func jsonArrayString(array: [AnyObject], brackets: Bool = true) -> String {
        var result = ""
        for (index, data) in array.enumerate() {
            if 0 != index {
                result += ","
            }
            result += "\(data)"
        }
        return brackets ? "[" + result + "]" : result
    }

    //打印 Data 内容
    func printData(data: NSData?) {
        if let tryData = data {
            print(String(NSString(data: tryData, encoding: NSUTF8StringEncoding)))
        } else {
            print("PrintData: 空数据")
        }
    }
}

