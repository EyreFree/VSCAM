

import UIKit

class BaseTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    weak var parentViewController: UIViewController?
    var sections = [BaseTableViewSection]()

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
        for section in sections {
            section.registerClass(tableView: self)
        }
    }

    //MARK:- tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].rows[indexPath.row].height(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row].cell(tableView: tableView, indexPath: indexPath)
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

    //Extern
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        Function.HideKeyboard()
    }
}

