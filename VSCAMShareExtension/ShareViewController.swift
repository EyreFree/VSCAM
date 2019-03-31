
import UIKit
import Social
import MobileCoreServices

extension String {
    //替换前缀
    func replacePrefix(string: String, with: String) -> String {
        if self.hasPrefix(string) {
            return with + String(self.dropFirst(string.characters.count))
        }
        return self
    }
}

// See http://stackoverflow.com/a/28037297/82609
extension NSObject {
    func callSelector(selector: Selector, object: AnyObject?) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            Thread.detachNewThreadSelector(selector, toTarget:self, with: object)
        }
    }
}

class ShareViewController: SLComposeServiceViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "VSCAM"
        self.textView.resignFirstResponder()

        didSelectPost()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.textView.isEditable = false
    }

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {
        if let imageItem = self.extensionContext?.inputItems.first as? NSExtensionItem {
            if let tryIndex = getUrlItemIndex() {
                if let imageItemProvider = imageItem.attachments?[tryIndex] as? NSItemProvider {
                    if imageItemProvider.hasItemConformingToTypeIdentifier(String(kUTTypeURL)) {
                        imageItemProvider.loadItem(forTypeIdentifier: String(kUTTypeURL), options: nil, completionHandler: {
                            [weak self] (item, error) in
                            if let strongSelf = self {
                                if let tryUrl = item as? NSURL {
                                    if let tryAbsoluteString = tryUrl.absoluteString {
                                        strongSelf.doOpenUrl(
                                            url: tryAbsoluteString.replacePrefix(string: "https", with: "vscams")
                                                .replacePrefix(string: "http", with: "vscam")
                                        )
                                        strongSelf.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                                    }
                                }
                            }
                        })
                    }
                }
            } else {
                if let imageItemProviders = imageItem.attachments as? [NSItemProvider] {
                    for (_, imageItemProvider) in imageItemProviders.enumerated() {
                        if imageItemProvider.hasItemConformingToTypeIdentifier(String(kUTTypeText)) {
                            imageItemProvider.loadItem(forTypeIdentifier: String(kUTTypeText), options: nil, completionHandler: {
                                [weak self] (item, error) in
                                if let strongSelf = self {
                                    if let tryUrl = item as? String {
                                        if tryUrl.hasPrefix("http") {
                                            strongSelf.doOpenUrl(
                                                url: tryUrl.replacePrefix(string: "https", with: "vscams")
                                                    .replacePrefix(string: "http", with: "vscam")
                                            )
                                            strongSelf.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            }
        }
    }

    override func configurationItems() -> [Any]! {
        return []
    }

    private func getUrlItemIndex() -> Int? {
        if let imageItem = self.extensionContext?.inputItems.first as? NSExtensionItem {
            if let imageItemProviders = imageItem.attachments as? [NSItemProvider] {
                for (index, value) in imageItemProviders.enumerated() {
                    if value.hasItemConformingToTypeIdentifier(String(kUTTypeURL)) {
                        return index
                    }
                }
            }
        }
        return nil
    }

    private func setContentText(text: String?) {
        if let tryText = text {
            self.textView.text = tryText
        }
    }

    // See http://stackoverflow.com/a/28037297/82609
    // Works fine for iOS 8.x and 9.0 but may not work anymore in the future :(
    private func doOpenUrl(url: String) {
        let urlNS = NSURL(string: url)!
        var responder = self as UIResponder?
        while (responder != nil) {
            if responder?.responds(to: Selector("openURL:")) == true {
                responder?.callSelector(selector: Selector("openURL:"), object: urlNS)
            }
            responder = responder!.next
        }
    }
}
