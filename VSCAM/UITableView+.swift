
import UIKit

extension UITableView {

    //滚动到指定位置
    open func setContentOffset(_ contentOffset: CGPoint, with duration: TimeInterval = 0.28) {
        UIView.animate(withDuration: duration) {
            self.contentOffset = contentOffset
        }
    }
}
