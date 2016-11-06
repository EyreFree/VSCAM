

import UIKit

class BaseCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var parentViewController: UIViewController?
    var items = [BaseCollectionViewItem]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    init(parentViewController: UIViewController) {
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

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return items[indexPath.section].cell(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return items[indexPath.section].size(collectionView, indexPath: indexPath)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: items[section].heightHeader(collectionView))
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: items[section].heightFooter(collectionView))
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview = UICollectionReusableView()

        switch kind {
        case UICollectionElementKindSectionHeader:
            reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(
                kind, withReuseIdentifier: items[indexPath.section].reuseIdentifier() + "Header", forIndexPath: indexPath
            )

            if let _ = reusableview.viewWithTag(Tag.CollectionViewItemHeaderView) {

            } else {
                let headerView = items[indexPath.section].header(collectionView)
                headerView.tag = Tag.CollectionViewItemHeaderView
                reusableview.addSubview(headerView)

                headerView.snp_makeConstraints {
                    (make) -> Void in
                    make.top.left.right.bottom.equalTo(0)
                }
            }

            break
        case UICollectionElementKindSectionFooter:
            reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(
                kind, withReuseIdentifier: items[indexPath.section].reuseIdentifier() + "Footer", forIndexPath: indexPath
            )

            if let _ = reusableview.viewWithTag(Tag.CollectionViewItemFooterView) {

            } else {
                let footerView = items[indexPath.section].footer(collectionView)
                footerView.tag = Tag.CollectionViewItemFooterView
                reusableview.addSubview(footerView)

                footerView.snp_makeConstraints {
                    (make) -> Void in
                    make.top.left.right.bottom.equalTo(0)
                }
            }
            
            break
        default:
            break
        }
        
        return reusableview;
    }
}

