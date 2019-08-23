
import UIKit

class AboutTableViewItemSelections: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(valueRGB: 0xF8F8F8)

        let tryController = (tableView as? AboutTableView)?.parentViewController as? AboutController

        //底部边框
        var bottomFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(7)) {
            bottomFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(7)
            cell.contentView.addSubview(imgView)
            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            bottomFrameView = imgView
        }

        if let tryBottomFrameView = bottomFrameView {
            //底部内边框
            var bottomFrameInView: UIView?
            if let view = tryBottomFrameView.viewWithTag(Tag.make(8)) {
                bottomFrameInView = view
            } else {
                let imgView = UIView()
                imgView.tag = Tag.make(8)
                tryBottomFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.center.equalTo(tryBottomFrameView)
                    make.width.equalTo(60)
                    make.height.equalTo(99)
                }
                bottomFrameInView = imgView
            }

            if let tryBottomFrameInView = bottomFrameInView {
                //去评分
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(9)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(9)
                    view.setTitle(String.Localized("去评分"), for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: #selector(AboutController.scoreClicked), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.top.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }

                //欢迎页面
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(10)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(10)
                    view.setTitle(String.Localized("欢迎页面"), for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: #selector(AboutController.welcomeClicked), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.center.equalTo(tryBottomFrameInView)
                        make.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }

                //隐私政策
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(11)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(10)
                    view.setTitle(String.Localized("隐私政策"), for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: #selector(AboutController.privacyClicked), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.bottom.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }
            }
        }

        return cell
    }

    override func height(tableView: UITableView) -> CGFloat {
        return CGSize.screen().height - 417 - 77
    }
}
