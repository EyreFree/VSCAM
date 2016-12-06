

import UIKit

class AboutTableViewItemFooter: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "AboutTableViewItemFooter"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(valueRGB: 0xF8F8F8)

        let tryController = (tableView as? AboutTableView)?.parentViewController as? AboutController

        //VSCAM
        if let _ = cell.contentView.viewWithTag(Tag.make(2)) as? UIButton {

        } else {
            let view = UIButton(type: .system)
            view.tag = Tag.make(2)
            view.setTitle("vscam.co", for: .normal)
            view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
            view.alpha = 0.35
            view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            view.addTarget(tryController, action: Selector(("vscamClicked")), for: .touchUpInside)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.center.equalTo(cell.contentView)
                make.width.equalTo(60)
                make.height.equalTo(18)
            }
        }

        return cell
    }

    override func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 77
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

