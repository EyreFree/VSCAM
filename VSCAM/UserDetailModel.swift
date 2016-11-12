

import Foundation

class UserDetailModel {

    var userData: UserObject?

    var userDetailData: UserInfoObject?
    var imageList: ImageListObject?

    var hasAvatar = false

    func refreshModel() {
        hasAvatar = false
        if let tryAvatar = userData?.avatar ?? userDetailData?.avatar {
            if tryAvatar != 0 {
                hasAvatar = true
            }
        }
    }
}
