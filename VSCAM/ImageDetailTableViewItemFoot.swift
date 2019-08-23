
import UIKit

class ImageDetailTableViewItemFoot: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none

        //占位
        cell.backgroundColor = UIColor.clear

        return cell
    }

    override func height(tableView: UITableView) -> CGFloat {
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryGps = (tryModel.imageBrief?.gps ?? tryModel.imageDetail?.gps) {
                if tryGps.isEmpty == false {
                    return 140
                }
            }
        }
        return 0
    }
}
