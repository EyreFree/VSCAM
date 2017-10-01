
import UIKit

extension UITableView {

    //无动画刷新 Section
    func reloadSections(indexArray: [Int]) {
        UIView.performWithoutAnimation {
            for index in indexArray {
                self.reloadSections(IndexSet(integer: index), with: .none)
            }
        }
    }

    //无动画刷新 Rows
    func reloadRows(indexPathArray: [IndexPath]) {
        UIView.performWithoutAnimation {
            self.reloadRows(at: indexPathArray, with: .none)
        }
    }

    //滚动到指定位置
    open func setContentOffset(_ contentOffset: CGPoint, with duration: TimeInterval = 0.28) {
        UIView.animate(withDuration: duration) {
            self.contentOffset = contentOffset
        }
    }
}
