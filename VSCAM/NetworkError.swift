

import Foundation

class NetworkError {

    var description: String!
    var error: String!

    init?(dict: NSDictionary) {
        if let tryError = dict["error"] as? String {
            self.error = tryError
            self.description = NetworkError.getContent(tryError)
        } else {
            return nil
        }
    }

    static func getContent(_ error: String) -> String {
        switch error {
        case "NO_LOGIN_PERMISSIONS":
            //这里做一下登出操作
            //LoginRegisterViewController.model.hasLoginMark = false
            //弹出登陆对话框
            //Function.openLoginRegisterView()
            //return "Ajax请求缺少登录权限"
            return "请先登录"
            //用于需要登录操作的请求验证。	跳转到contextPath/login.htm?returnUrl=encodeURIComponent后的本页面URL地址 。
        //注意:contextPath是需要设置的全局主网站根路径，由于存在多个子域名调用，因此这里不能使用相对路径。
        case "AUTHCODE_INCORRECT":
            return "验证码错误"
        //用于登录注册页面验证码校验。	注册登录页面显示相应的错误提示层。
        case "USERNAME_NOT_EXIST":
            return "用户名不存在"
        //用于登录页面验证用户名或者邮箱登录错误。	登录页面显示相应的错误提示层。
        case "USERNAME_IS_EXIST":
            return "用户名已存在"
        //用于注册页面验证用户名是否存在错误。	注册页面显示相应的错误提示层。
        case "USERNAME_CONTAINS_SPECIFIC_SYMBOL":
            return "用户名包含特殊字符和空格"
        //用于注册页面校验用户名格式错误。	注册页面显示相应的错误提示层。
        case "PASSWORD_INCORRECT":
            return "用户密码错误"
            //用于登录页面验证用户密码错误。	登录页面显示相应的错误提示层。
        //个人资料页面修改密码返回错误并显示相应错误提示层。
        case "EMAIL_FORMAT_INCORRECT":
            return "邮箱格式不正确"
        //用于注册页面提示用户输入正确的邮箱地址。	注册页面显示相应的错误提示层。
        case "EMAIL_IS_EXIST":
            return "邮箱已存在"
        //用于注册页面验证邮箱是否存在错误。	注册页面显示相应的错误提示层。
        case "EMAIL_NOT_EXIST":
            return "邮箱不存在"
        //用户登录页面重置密码验证邮箱是否存在错误。	登录页面重置密码提示层显示相应错误。
        case "EMAIL_NOT_VERIFIED":
            return "邮箱未经过验证"
        //用户登录页面重置密码判断邮箱是否验证过。	登录页面重置密码提示层显示相应错误。
        case "PAYMENT_PASSWORD_IS_EXIST":
            return "支付密码已存在"
        //用于个人资料页面判断是否已经设置过支付密码。	个人资料页面设置支付时若密码已存在，需要更改支付密码相应的页面元素。
        case "PAYMENT_PASSWORD_INCORRECT":
            return "支付密码错误"
        //用户个人资料页面修改支付密码判断支付密码。	个人资料页面修改支付密码提示层显示相应错误。
        default:
            return error
        }
    }
}

