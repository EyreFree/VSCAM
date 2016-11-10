

import UIKit

class ImageDetailTableViewItemHead: BaseTableViewItem {

    //MARK:- Identifier
    override func reuseIdentifier() ->String {
        return "ImageDetailTableViewItemHead"
    }

    //MARK:- Cell
    override func cell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
        cell.selectionStyle = .none

        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {

            let image = UIImage.placeholder
            var imageUrlString: String?
            if let tryWbpid = (tryModel.imageBrief?.wbpid ?? tryModel.imageDetail?.wbpid) {
                if tryWbpid.isEmpty == false {
                    imageUrlString = NetworkURL.imageWBBig + tryWbpid
                } else if let tryOrigin = (tryModel.imageBrief?.origin ?? tryModel.imageDetail?.origin) {
                    imageUrlString = NetworkURL.imageOriginBig.replace(string: "{origin}", with: tryOrigin)
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
        let screenWidth = UIScreen.main.bounds.size.width
        if let tryModel = ((tableView as? ImageDetailTableView)?.parentViewController as? ImageDetailController)?.model {
            if let tryScale = (tryModel.imageBrief?.scale ?? tryModel.imageDetail?.scale) {
                return screenWidth * tryScale.f()
            }
        }
        return screenWidth
    }

    override func number(tableView: UITableView) -> Int {
        return 1
    }
}

