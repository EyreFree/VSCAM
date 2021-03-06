
import Foundation

class UserDetailModel {

    var userData: UserObject?

    var userDetailData: UserInfoObject?
    var imageList: ImageListObject?

    var hasAvatar = false
    var isSelf = false

    var needRefreshList = false

    func refreshModel() {
        hasAvatar = false
        if let tryAvatar = userData?.avatar ?? userDetailData?.avatar {
            if tryAvatar != 0 {
                hasAvatar = true
            }
        }

        isSelf = false
        if let tryUID = userData?.uid ?? userDetailData?.uid {
            isSelf = Variable.loginUserInfo?.uid == tryUID
        }
    }
}
