

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
            var presetString = ((tryModel.imageBrief?.preset ?? tryModel.imageDetail?.preset) ?? "").uppercased()
            if presetString.isEmpty == true {
                presetString = "-"
            }
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
                let date = Date.fromValue(value: tryTime)
                dateString = date.toString(format: date.getYear() != Date().getYear() ? "yyyy年MM月dd日" : "MM月dd日")
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

            //标题
            let titleString = ((tryModel.imageBrief?.text ?? tryModel.imageDetail?.text) ?? "未知")
            if let view = cell.contentView.viewWithTag(Tag.make(9)) as? UILabel {
                view.text = titleString
            } else {
                let imgView = UILabel()
                imgView.tag = Tag.make(9)
                imgView.text = titleString
                imgView.font = UIFont.systemFont(ofSize: 16)
                imgView.textColor = UIColor.black
                imgView.textAlignment = .center
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.equalTo(60)
                    make.left.equalTo(25)
                    make.right.equalTo(-25)
                    make.height.equalTo(20)
                }
            }

            //光圈和ISO边框
            let infoBackView: UIView?
            if let view = cell.contentView.viewWithTag(Tag.make(8)) {
                infoBackView = view
            } else {
                let view = UIView()
                view.tag = Tag.make(8)
                cell.contentView.addSubview(view)
                view.snp.makeConstraints {
                    (make) -> Void in
                    make.height.equalTo(30)
                    make.bottom.equalTo(-54)
                    make.centerX.equalTo(cell.contentView)
                }
                infoBackView = view
            }

            if let tryInfoBackView = infoBackView {
                //光圈图标
                if let view = tryInfoBackView.viewWithTag(Tag.make(4)) as? UIImageView {
                    view.removeFromSuperview()
                }
                let apertureIconView = UIImageView()
                apertureIconView.tag = Tag.make(4)
                apertureIconView.image = UIImage(named: "图标_光圈")
                apertureIconView.contentMode = .center
                tryInfoBackView.addSubview(apertureIconView)
                apertureIconView.snp.makeConstraints {
                    (make) -> Void in
                    make.width.height.equalTo(30)
                    make.bottom.equalTo(0)
                    make.left.equalTo(0)
                }

                //光圈文字
                var apertureString = ""
                if let tryApertureValue = tryModel.imageBrief?.aperture {
                    apertureString = "\(Int(tryApertureValue))"
                    let xiaoshu = Int((tryApertureValue + 0.05) * 10) % 10
                    if xiaoshu != 0 {
                        apertureString += ".\(xiaoshu)"
                    }
                } else if let tryApertureString = tryModel.imageDetail?.exif?.COMPUTED?.ApertureFNumber {
                    apertureString = tryApertureString
                }
                if apertureString.isEmpty == true {
                    apertureString = "-"
                } else {
                    apertureString = "f/" + apertureString
                }
                if let view = tryInfoBackView.viewWithTag(Tag.make(5)) as? UILabel {
                    view.removeFromSuperview()
                }
                let apertureTextView = UILabel()
                apertureTextView.tag = Tag.make(5)
                apertureTextView.text = apertureString
                apertureTextView.font = UIFont.boldSystemFont(ofSize: 24)
                apertureTextView.textColor = UIColor.black
                apertureTextView.textAlignment = .left
                apertureTextView.sizeToFit()
                tryInfoBackView.addSubview(apertureTextView)
                apertureTextView.snp.makeConstraints {
                    (make) -> Void in
                    make.centerY.equalTo(apertureIconView)
                    make.left.equalTo(apertureIconView.snp.right).offset(10)
                    make.width.equalTo(apertureTextView.frame.width)
                    make.height.equalTo(30)
                }

                //ISO图标
                if let view = tryInfoBackView.viewWithTag(Tag.make(6)) as? UIImageView {
                    view.removeFromSuperview()
                }
                let isoIconView = UIImageView()
                isoIconView.tag = Tag.make(6)
                isoIconView.image = UIImage(named: "图标_ISO")
                isoIconView.contentMode = .center
                tryInfoBackView.addSubview(isoIconView)
                isoIconView.snp.makeConstraints {
                    (make) -> Void in
                    make.width.equalTo(35)
                    make.height.equalTo(19)
                    make.centerY.equalTo(apertureIconView)
                    make.left.equalTo(apertureTextView.snp.right).offset(39)
                }

                //ISO文字
                var isoString = ""
                if let tryISOValue = (tryModel.imageBrief?.iso ?? tryModel.imageDetail?.exif?.EXIF?.ISOSpeedRatings) {
                    isoString = "\(tryISOValue)"
                }
                if isoString.isEmpty == true {
                    isoString = "-"
                }
                if let view = tryInfoBackView.viewWithTag(Tag.make(7)) as? UILabel {
                    view.removeFromSuperview()
                }
                let isoTextView = UILabel()
                isoTextView.tag = Tag.make(7)
                isoTextView.text = isoString
                isoTextView.font = UIFont.boldSystemFont(ofSize: 24)
                isoTextView.textColor = UIColor.black
                isoTextView.textAlignment = .left
                isoTextView.sizeToFit()
                tryInfoBackView.addSubview(isoTextView)
                isoTextView.snp.makeConstraints {
                    (make) -> Void in
                    make.centerY.equalTo(apertureIconView)
                    make.left.equalTo(isoIconView.snp.right).offset(10)
                    make.width.equalTo(isoTextView.frame.width)
                    make.height.equalTo(30)
                    make.right.equalTo(0)
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

