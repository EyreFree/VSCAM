

import UIKit

class BaseTableViewSection: NSObject {

    var indexSection = 0
    var rows = [BaseTableViewRow]()

    //MARK:- Identifier
    func registerClass(tableView: UITableView) {
        for row in rows {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: row.reuseIdentifier())
        }
    }

    //MARK:- Cell
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].cell(tableView: tableView)
    }

    func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].height(tableView: tableView)
    }

    func number(tableView: UITableView) -> Int {
        return rows.count
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

