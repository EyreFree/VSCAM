
import UIKit

class BaseCollectionViewItem {

    //MARK:- Identifier
    func reuseIdentifier() -> String {
        return "BaseCollectionViewItem"
    }

    func registerClass(collectionView: UICollectionView) {
        collectionView.register(
            UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: reuseIdentifier() + "Header"
        )
        collectionView.register(
            UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: reuseIdentifier() + "Footer"
        )
        for index in 0 ..< number(collectionView: collectionView) {
            collectionView.register(
                UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier() + "\(index)"
            )
        }
    }

    //MARK:- Cell
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier() + "\(indexPath.row)", for: indexPath
        )
    }

    func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }

    func number(collectionView: UICollectionView) -> Int {
        return 0
    }

    //MARK:- Header
    func header(collectionView: UICollectionView) -> UIView {
        return UIView()
    }

    func heightHeader(collectionView: UICollectionView) -> CGFloat {
        return CGFloat.zeroHeight
    }

    //MARK:- Footer
    func footer(collectionView: UICollectionView) -> UIView {
        return UIView()
    }

    func heightFooter(collectionView: UICollectionView) -> CGFloat {
        return CGFloat.zeroHeight
    }
}
