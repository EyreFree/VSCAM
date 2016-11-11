

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
}

