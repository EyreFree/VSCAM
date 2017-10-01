
import UIKit

class AboutTableViewItemHeader: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(valueRGB: 0xF8F8F8)

        //图标
        if let _ = cell.contentView.viewWithTag(Tag.make(3)) as? UIImageView {

        } else {
            let view = UIImageView()
            view.tag = Tag.make(3)
            view.contentMode = .scaleAspectFit
            view.image = UIImage(named: "icon")
            cell.contentView.addSubview(view)
            view.snp.makeConstraints {
                (make) -> Void in
                make.width.height.equalTo(86)
                make.top.equalTo(136)
                make.centerX.equalTo(cell.contentView)
            }
        }

        //VSCAM
        if let _ = cell.contentView.viewWithTag(Tag.make(4)) as? UILabel {

        } else {
            let titleView = UILabel()
            titleView.tag = Tag.make(4)
            titleView.font = UIFont.systemFont(ofSize: 24)
            titleView.textColor = UIColor.black
            titleView.text = "VSCAM"
            titleView.textAlignment = .center
            cell.contentView.addSubview(titleView)

            titleView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(228)
                make.centerX.equalTo(cell.contentView)
                make.width.equalTo(190)
                make.height.equalTo(24)
            }
        }

        //Version
        if let _ = cell.contentView.viewWithTag(Tag.make(5)) as? UILabel {

        } else {
            let titleView = UILabel()
            titleView.tag = Tag.make(5)
            titleView.font = UIFont.systemFont(ofSize: 14)
            titleView.textColor = UIColor(valueRGB: 0x666666)
            titleView.text = "\(Variable.versionLocal ?? String.Localized("未知版本"))"
            titleView.textAlignment = .center
            cell.contentView.addSubview(titleView)

            titleView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(255)
                make.centerX.equalTo(cell.contentView)
                make.width.equalTo(146)
                make.height.equalTo(17)
            }
        }

        //slogon
        if let _ = cell.contentView.viewWithTag(Tag.make(6)) as? UILabel {

        } else {
            let titleView = UILabel()
            titleView.tag = Tag.make(6)
            titleView.font = UIFont.systemFont(ofSize: 14)
            titleView.textColor = UIColor.black
            titleView.text = String.Localized("手机拍摄、胶片味、意识流")
            titleView.alpha = 0.35
            titleView.textAlignment = .center
            cell.contentView.addSubview(titleView)

            titleView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(295)
                make.centerX.equalTo(cell.contentView)
                make.width.equalTo(302)
                make.height.equalTo(17)
            }
        }

        return cell
    }
    
    override func height(tableView: UITableView) -> CGFloat {
        return 417
    }
}
