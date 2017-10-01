

import UIKit

class SettingTableViewItemExt: BaseTableViewRow {

    //MARK:- Cell
    override func cell(tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier()) ?? UITableViewCell(
            style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier()
        )
        cell.selectionStyle = .none

        let tryController = (tableView as? SettingTableView)?.parentViewController as? SettingController

        //底部边框
        var bottomFrameView: UIView?
        if let view = cell.contentView.viewWithTag(Tag.make(16)) {
            bottomFrameView = view
        } else {
            let imgView = UIView()
            imgView.tag = Tag.make(16)
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
            if let view = tryBottomFrameView.viewWithTag(Tag.make(17)) {
                bottomFrameInView = view
            } else {
                let imgView = UIView()
                imgView.tag = Tag.make(17)
                tryBottomFrameView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.center.equalTo(tryBottomFrameView)
                    make.width.equalTo(80)
                    make.height.equalTo(66)
                }
                bottomFrameInView = imgView
            }

            if let tryBottomFrameInView = bottomFrameInView {
                //删除头像
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(18)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(18)
                    view.setTitle(String.Localized("清理缓存"), for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: Selector(("clearCacheClicked")), for: .touchUpInside)
                    tryBottomFrameInView.addSubview(view)
                    view.snp.makeConstraints {
                        (make) -> Void in
                        make.top.left.right.equalTo(0)
                        make.height.equalTo(18)
                    }
                }

                //退出登录
                if let _ = tryBottomFrameInView.viewWithTag(Tag.make(19)) as? UIButton {

                } else {
                    let view = UIButton(type: .system)
                    view.tag = Tag.make(19)
                    view.setTitle(String.Localized("关于 VSCAM"), for: .normal)
                    view.setTitleColor(UIColor(valueRGB: 0x0E0E0E), for: .normal)
                    view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    view.addTarget(tryController, action: Selector(("aboutClicked")), for: .touchUpInside)
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
        return 140
    }
}

