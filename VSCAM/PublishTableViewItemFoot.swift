

import UIKit

class PublishTableViewItemFoot: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none

        //占位
        cell.backgroundColor = UIColor.clear

        return cell
    }

    override func height(tableView: UITableView) -> CGFloat {
        return 89
    }
}

