

import UIKit

class BaseTableViewSection {

    var rows = [BaseTableViewRow]()

    //MARK:- Identifier
    func registerClass(tableView: UITableView) {
        for row in rows {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: row.reuseIdentifier())
        }
    }

    //MARK:- Cell
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: rows[indexPath.section].reuseIdentifier(), for: indexPath)
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

