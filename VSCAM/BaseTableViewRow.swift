

import UIKit

class BaseTableViewRow: NSObject {

    var indexSection = 0
    var indexRow = 0

    //MARK:- Identifier
    func reuseIdentifier() -> String {
        return String(describing: type(of: self))
    }

    //MARK:- IndexPath
    func rowIndexPath() -> IndexPath {
        return IndexPath(row: indexRow, section: indexSection)
    }

    //MARK:- Cell
    func cell(tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(), for: rowIndexPath())
    }

    func height(tableView: UITableView) -> CGFloat {
        return 0
    }
}

