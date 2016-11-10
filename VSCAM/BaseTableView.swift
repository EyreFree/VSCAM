

import UIKit

class BaseTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    weak var parentViewController: UIViewController?
    var items = [BaseTableViewItem]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        fatalError("init(coder:) has not been implemented")
    }

    init(_ parentViewController: UIViewController) {
        super.init(frame: CGRect.zero, style: .grouped)
        self.parentViewController = parentViewController
    }

    func onInit() {
        //添加数据
        fatalError("onInit() has not been implemented")
    }

    func addReuseIdentifier() {
        for item in items {
            item.registerClass(tableView: self)
        }
    }

    //MARK:- tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].number(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.section].height(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return items[indexPath.section].cell(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return items[section].heightHeader(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return items[section].header(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return items[section].heightFooter(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return items[section].footer(tableView: tableView)
    }
}

