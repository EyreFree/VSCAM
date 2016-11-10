

import UIKit

class BaseTableViewItem {

    //MARK:- Identifier
    func reuseIdentifier() -> String {
        return "BaseTableViewItem"
    }

    func registerClass(tableView: UITableView) {
        for index in 0 ..< number(tableView: tableView) {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier() + "\(index)")
        }
    }

    //MARK:- Cell
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
    }

    func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 0
    }

    func number(tableView: UITableView) -> Int {
        return 0
    }

    //MARK:- Header
    func header(tableView: UITableView) -> UIView {
        return UIView()
    }

    func heightHeader(tableView: UITableView) -> CGFloat {
        return CGFloat.zeroHeight
    }

    //MARK:- Footer
    func footer(tableView: UITableView) -> UIView {
        return UIView()
    }

    func heightFooter(tableView: UITableView) -> CGFloat {
        return CGFloat.zeroHeight
    }
}

