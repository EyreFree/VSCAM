

import UIKit

class ImageDetailTableViewItemHead: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "ImageDetailTableViewItemHead"
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
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryScale = (tryModel.imageBrief?.scale ?? tryModel.imageDetail?.scale) {
                return screenWidth * tryScale.f()
            }
        }
        return screenWidth
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

