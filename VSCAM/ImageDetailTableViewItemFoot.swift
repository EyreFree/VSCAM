

import UIKit

class ImageDetailTableViewItemFoot: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "ImageDetailTableViewItemFoot"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {

            let image = UIImage.placeholderTransparent
            var imageUrlString: String?
            if let tryGps = (tryModel.imageBrief?.gps ?? tryModel.imageDetail?.gps) {
                if tryGps.isEmpty == false {
                    imageUrlString = NetworkURL.imageMap.replace(string: "{gps}", with: tryGps)
                }
            }

            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = cell.contentView.viewWithTag(Tag.make(0)) as? UIImageView {
                imgView.image = image
                imgViewReal = imgView
            } else {
                let imgView = UIImageView()
                imgView.tag = Tag.make(0)
                imgView.backgroundColor = UIColor(valueRGB: 0x222222)
                imgView.image = image
                imgView.contentMode = .scaleAspectFit
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.left.right.bottom.equalTo(0)
                }
                imgViewReal = imgView
            }
            if let tryUrlString = imageUrlString {
                imgViewReal.setImageWithURLString(UrlString: tryUrlString)
            }
        }

        return cell
    }

    override func height(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 140
    }

    override func number(tableView: UITableView) -> Int {
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryGps = (tryModel.imageBrief?.gps ?? tryModel.imageDetail?.gps) {
                if tryGps.isEmpty == false {
                    return 1
                }
            }
        }
        return 0
    }
}

