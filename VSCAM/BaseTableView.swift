
import UIKit

class BaseTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var sections = [BaseTableViewSection]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect.zero, style: .grouped)
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
        return sections[section].number(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].height(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell(tableView: tableView, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].heightHeader(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].header(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].heightFooter(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footer(tableView: tableView)
    }

    //Extern
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        Function.HideKeyboard()
    }
}
