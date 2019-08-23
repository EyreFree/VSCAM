
import UIKit

class UserDetailCollectinViewItem: BaseCollectionViewItem {

    override func reuseIdentifier() -> String {
        return "UserDetailCollectinViewItem"
    }

    override func number(collectionView: UICollectionView) -> Int {
        return ((collectionView as? UserDetailCollectinView)?.parentViewController as? UserDetailController)?.model?.imageList?.grids?.count ?? 0
    }

    override func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )

        if let tryData = ((collectionView as? UserDetailCollectinView)?.parentViewController as? UserDetailController)?.model?.imageList {

            let title = tryData.grids?[indexPath.row].user?.name ?? Define.placeHolderString
            let image = UIImage.placeholderTransparent
            var imageUrlString: String?
            if let tryWbpid = tryData.grids?[indexPath.row].wbpid {
                if tryWbpid.isEmpty == false {
                    imageUrlString = NetworkURL.imageWBSmall + tryWbpid
                } else if let tryOrigin = tryData.grids?[indexPath.row].origin {
                    imageUrlString = NetworkURL.imageOriginSmall.replace(string: "{origin}", with: tryOrigin)
                }
            }

            //背景图片
            var imgViewReal: UIImageView!
            if let imgView = cell.contentView.viewWithTag(Tag.make(2)) as? UIImageView {
                imgView.image = image
                imgViewReal = imgView
            } else {
                let imgView = UIImageView()
                imgView.tag = Tag.make(2)
                imgView.image = image
                imgView.contentMode = .scaleAspectFit
                cell.contentView.addSubview(imgView)
                imgView.snp.makeConstraints {
                    (make) -> Void in
                    make.top.left.right.equalTo(0)
                    make.bottom.equalTo(-30)
                }
                imgViewReal = imgView
            }
            if let tryUrlString = imageUrlString {
                imgViewReal.setImageWithURLString(UrlString: tryUrlString)
            }

            //标题
            if let titleView = cell.contentView.viewWithTag(Tag.make(3)) as? UILabel {
                titleView.text = title
            } else {
                let titleView = UILabel()
                titleView.tag = Tag.make(3)
                titleView.font = UIFont.boldSystemFont(ofSize: 10)
                titleView.textColor = UIColor(valueRGB: 0x535353)
                titleView.text = title
                titleView.textAlignment = .center
                cell.contentView.addSubview(titleView)

                titleView.snp.makeConstraints {
                    (make) -> Void in
                    make.left.right.equalTo(0)
                    make.bottom.equalTo(-10)
                    make.height.equalTo(20)
                }
            }
        }
        return cell
    }

    override func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let screenWidth = CGFloat(UIScreen.main.bounds.size.width - 30) / CGFloat(2.0)
        if let tryScale = ((collectionView as? UserDetailCollectinView)?.parentViewController as? UserDetailController)?.model?.imageList?.grids?[indexPath.row].scale {
            return CGSize(width: screenWidth, height: screenWidth * tryScale.cgFloat + 30)
        }
        return CGSize(width: screenWidth, height: screenWidth)
    }
}
