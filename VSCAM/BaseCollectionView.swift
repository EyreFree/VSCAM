
import UIKit

class BaseCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var parentViewController: UIViewController?
    var items = [BaseCollectionViewItem]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    init(_ parentViewController: UIViewController) {
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        self.parentViewController = parentViewController
    }

    func onInit() {
        //添加数据
        fatalError("onInit() has not been implemented")
    }

    func addReuseIdentifier() {
        for item in items {
            item.registerClass(collectionView: self)
        }
    }

    //MARK:- tableview
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].number(collectionView: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return items[indexPath.section].cell(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return items[indexPath.section].size(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: items[section].heightHeader(collectionView: collectionView))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: items[section].heightFooter(collectionView: collectionView))
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview = UICollectionReusableView()

        switch kind {
        case UICollectionElementKindSectionHeader:
            reusableview = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: items[indexPath.section].reuseIdentifier() + "Header", for: indexPath
            )
            if let view = reusableview.viewWithTag(Tag.make(0)) {
                view.removeFromSuperview()
            }
            let headerView = items[indexPath.section].header(collectionView: collectionView)
            headerView.tag = Tag.make(0)
            reusableview.addSubview(headerView)
            headerView.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            break
        case UICollectionElementKindSectionFooter:
            reusableview = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: items[indexPath.section].reuseIdentifier() + "Footer", for: indexPath
            )
            if let view = reusableview.viewWithTag(Tag.make(1)) {
                view.removeFromSuperview()
            }
            let footerView = items[indexPath.section].footer(collectionView: collectionView)
            footerView.tag = Tag.make(1)
            reusableview.addSubview(footerView)
            footerView.snp.makeConstraints {
                (make) -> Void in
                make.top.left.right.bottom.equalTo(0)
            }
            break
        default:
            break
        }
        
        return reusableview;
    }
}
