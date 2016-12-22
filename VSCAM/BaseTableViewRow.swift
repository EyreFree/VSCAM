

import UIKit

class BaseTableViewRow {

    //MARK:- Identifier
    func reuseIdentifier() -> String {
        return "BaseTableViewRow"
    }

    //MARK:- Cell
    func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(), for: indexPath)
    }

    func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

