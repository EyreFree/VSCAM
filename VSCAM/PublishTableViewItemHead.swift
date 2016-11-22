

import UIKit

class PublishTableViewItemHead: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "PublishTableViewItemHead"
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
        let screenWidth = UIScreen.main.bounds.size.width
        if let tryModel = ((tableView as? PublishTableView)?.parentViewController as? PublishController)?.model {
            if let tryScale = tryModel.image?.aspectRatio() {
                return screenWidth * tryScale
            }
        }
        return screenWidth
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

