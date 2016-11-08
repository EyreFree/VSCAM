

import UIKit

class MainCollectinViewItem: BaseCollectionViewItem {

    override func reuseIdentifier() -> String {
        return "MainCollectinViewItem"
    }

    override func number(collectionView: UICollectionView) -> Int {
        return 5
    }

    override func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )

        let title = "测试标题"
        let image = UIImage.placeholder

        //背景图片
        if let imgView = cell.contentView.viewWithTag(Tag.make(0)) as? UIImageView {
            imgView.image = image
        } else {
            let imgView = UIImageView()
            imgView.tag = Tag.make(0)
            imgView.image = image
            imgView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imgView)

            imgView.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(cell.contentView)
            }
        }

        //标题
        if let titleView = cell.contentView.viewWithTag(Tag.make(1)) as? UILabel {
            titleView.text = title
        } else {
            let titleView = UILabel()
            titleView.tag = Tag.make(1)
            titleView.font = UIFont.boldSystemFont(ofSize: 16)
            titleView.backgroundColor = UIColor(black: 1, alpha: 0.6)
            titleView.textColor = UIColor.white
            titleView.text = title
            titleView.textAlignment = .center
            cell.contentView.addSubview(titleView)

            titleView.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(cell.contentView)
            }
        }

        return cell
    }

    override func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        //控制cell宽度，每行2个正方形
        let cellWidth = CGFloat(UIScreen.main.bounds.size.width - 3) / CGFloat(2.0)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

