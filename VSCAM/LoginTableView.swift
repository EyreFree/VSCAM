
import UIKit

class LoginTableView: BaseTableView {

    override init() {
        super.init()
        onInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func onInit() {
        //添加数据
        let section1 = BaseTableViewSection()
        section1.rows.append(LoginTableViewItem())
        sections.append(section1)

        //UITableView设置
        self.delegate = self
        self.dataSource = self

        self.showsVerticalScrollIndicator = false
        self.bounces = true
        self.alwaysBounceVertical = true
        self.isScrollEnabled = true
        self.backgroundColor = UIColor.clear
        self.separatorColor = UIColor.clear
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        addReuseIdentifier()
    }

    //MARK:- tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
}
