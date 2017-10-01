
import UIKit

class ImageDetailTableViewItemHead: BaseTableViewRow {

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
        let screenWidth = UIScreen.main.bounds.size.width
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryScale = (tryModel.imageBrief?.scale ?? tryModel.imageDetail?.scale) {
                return screenWidth * tryScale.f()
            }
        }
        return screenWidth
    }
}
