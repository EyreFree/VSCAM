

import UIKit

class PublishTableViewItemFoot: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "PublishTableViewItemFoot"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        //占位
        cell.backgroundColor = UIColor.clear

        return cell
    }

    override func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 89
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

