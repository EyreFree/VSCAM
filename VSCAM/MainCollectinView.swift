

import UIKit

class MainCollectinView: BaseCollectionView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    override init(parentViewController: UIViewController) {
        super.init(parentViewController: parentViewController)
        onInit()
    }

    override func onInit() {
        items.append(MainCollectinViewItem())

        self.delegate = self
        self.dataSource = self

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.sectionInset = UIEdgeInsets(top: 3 , left: 0, bottom: 3, right: 0)
        self.collectionViewLayout = flowLayout

        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        self.bounces = true
        self.alwaysBounceVertical = true
        self.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: CGFloat.tabBar(parentViewController), right: 0
        )
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        addReuseIdentifier()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

        print(indexPath)
    }
}

