

import UIKit

class ImageDetailTableViewItemFoot: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "ImageDetailTableViewItemFoot"
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
        return 210
    }

    override func number(tableView: UITableView) -> Int {
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryGps = (tryModel.imageBrief?.gps ?? tryModel.imageDetail?.gps) {
                if tryGps.isEmpty == false {
                    return 1
                }
            }
        }
        return 0
    }
}

