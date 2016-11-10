

import UIKit

class ImageDetailTableViewItemBody: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "ImageDetailTableViewItemBody"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {

            //线
            if let _ = cell.contentView.viewWithTag(Tag.make(0)) {

            } else {
                let imgView = UIView()
                imgView.tag = Tag.make(0)
                imgView.backgroundColor = UIColor(valueRGB: 0xdddddd)
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(219)
                    make.width.equalTo(272)
                    make.height.equalTo(1)
                    make.centerX.equalTo(cell.contentView)
                }
            }

            //滤镜
            let presetString = ((tryModel.imageBrief?.preset ?? tryModel.imageDetail?.preset) ?? "-").uppercased()
            if let view = cell.contentView.viewWithTag(Tag.make(1)) as? UILabel {
                view.text = presetString
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(1)
                imgView.text = presetString
                imgView.font = UIFont.boldSystemFont(ofSize: 32)
                imgView.textColor = UIColor.white
                imgView.textAlignment = .center
                imgView.backgroundColor = UIColor(valueRGB: 0xAA0044)
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(110)
                    make.width.height.equalTo(60)
                    make.centerX.equalTo(cell.contentView)
                }
            }

            //作者
            let userString = ((tryModel.imageBrief?.user?.name ?? tryModel.imageDetail?.user?.name) ?? "未知")
            if let view = cell.contentView.viewWithTag(Tag.make(2)) as? UILabel {
                view.text = userString
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(2)
                imgView.text = userString
                imgView.font = UIFont.systemFont(ofSize: 14)
                imgView.textColor = UIColor.black
                imgView.textAlignment = .left
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(20)
                    make.left.equalTo(25)
                    make.width.equalTo(cell.contentView).dividedBy(2).offset(-30)
                    make.height.equalTo(16)
                }
            }

            //日期
            var dateString = "未知"
            if let tryTime = (tryModel.imageBrief?.unix ?? tryModel.imageDetail?.unix) {
                dateString = Date.fromValue(value: tryTime).toString(format: "yyyy年MM月dd日")
            }
            if let view = cell.contentView.viewWithTag(Tag.make(3)) as? UILabel {
                view.text = dateString
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(3)
                imgView.text = dateString
                imgView.font = UIFont.systemFont(ofSize: 12)
                imgView.textColor = UIColor(valueRGB: 0x878787)
                imgView.textAlignment = .right
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(20)
                    make.right.equalTo(-25)
                    make.width.equalTo(cell.contentView).dividedBy(2).offset(-30)
                    make.height.equalTo(16)
                }
            }
        }

        return cell
    }

    override func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 333
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

