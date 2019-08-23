
import UIKit

class PublishTableViewItemHead: BaseTableViewRow {

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
        let screenWidth = UIScreen.main.bounds.size.width
        if let tryModel = ((tableView as? PublishTableView)?.parentViewController as? PublishController)?.model {
            if let tryScale = tryModel.image?.aspectRatio() {
                return screenWidth * tryScale
            }
        }
        return screenWidth
    }
}
