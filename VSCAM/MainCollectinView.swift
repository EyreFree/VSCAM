
import UIKit

class MainCollectinView: BaseCollectionView, MyWaterflowLayoutDelegate {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        super.init()
        onInit()
    }

    override func onInit() {
        items.append(MainCollectinViewItem())

        self.delegate = self
        self.dataSource = self

        let myWaterflowLayout = MyWaterflowLayout()
        myWaterflowLayout.delegate = self
        self.collectionViewLayout = myWaterflowLayout

        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = false
        self.bounces = true
        self.alwaysBounceVertical = true
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        addReuseIdentifier()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)

        (parentViewController as? MainController)?.clickImageAt(index: indexPath.row)
    }

    //MyWaterflowLayoutDelegate
    func waterflowLayout(_ waterflowLayout: MyWaterflowLayout!, heightForWidth width: CGFloat, at indexPath: IndexPath!) -> CGFloat {
        return items[indexPath.section].size(collectionView: self, indexPath: indexPath).height
    }
}
