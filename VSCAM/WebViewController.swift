

import UIKit
import NJKWebViewProgress
import SnapKit

class WebViewController: BaseViewController, UIWebViewDelegate, NJKWebViewProgressDelegate {

    private var webView: UIWebView!
    var _progressView: NJKWebViewProgressView!
    var _progressProxy: NJKWebViewProgress!

    var url: NSURL!

    var htmlContent: String!

    //网页自动缩放
    var autoScale = true

    init(contentString: String, title: String = "") {
        super.init(nibName: nil, bundle: nil)

        self.htmlContent = contentString
        self.navigationItem.title = title
    }

    init(url: NSURL!, title: String = "") {
        super.init(nibName: nil, bundle: nil)

        self.url = url
        self.navigationItem.title = title
    }

    init(urlString: String, title: String = "") {
        super.init(nibName: nil, bundle: nil)

        self.url = NSURL(myString: urlString)
        self.navigationItem.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addNavigationButtonWithImage()
        self.title = ""
        self.view.backgroundColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.addWhiteBackground()
        if nil != _progressView {
            navigationController?.navigationBar.addSubview(_progressView)
        }
    }

    var initMark = true
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if initMark {
            initMark = false

            addControl()
            loadPage()

            if nil != _progressView {
                navigationController?.navigationBar.addSubview(_progressView)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.addWhiteBackground()
        _progressView?.removeFromSuperview()
    }

    func addControl() {
        webView = UIWebView()
        webView.delegate = self
        webView.scalesPageToFit = autoScale
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.contentInset = UIEdgeInsets(
            top: 0, left: 0, bottom: 0, right: 0
        )
        webView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.view.addSubview(webView)

        webView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(CGFloat.statusBar() + CGFloat.navigationBar(controller: self))
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }

        _progressProxy = NJKWebViewProgress()
        webView.delegate = _progressProxy
        _progressProxy.webViewProxyDelegate = self
        _progressProxy.progressDelegate = self

        let progressBarHeight = 2.f()
        let navigationBarBounds = self.navigationController?.navigationBar.bounds ?? CGRect.zero
        let barFrame = CGRect(
            x: 0, y: navigationBarBounds.size.height - progressBarHeight,
            width: navigationBarBounds.size.width, height: progressBarHeight
        )
        _progressView = NJKWebViewProgressView(frame: barFrame)
        _progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    }

    private func loadPage() {
        if let tryHtmlContent = htmlContent {
            webView.loadHTMLString(tryHtmlContent, baseURL: nil)
        } else if let tryUrl = url as? URL {
            webView.loadRequest(URLRequest(url: tryUrl))
        }
    }

    //MARK:- NJKWebViewProgressDelegate
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        _progressView.setProgress(progress, animated: true)

        if let tryTitle = webView.stringByEvaluatingJavaScript(from: "document.title"), (false == String.isEmpty(string: tryTitle)) {
            self.title = tryTitle
        } else {
            self.title = ""
        }
    }

    //MARK:- 导航栏
    func addNavigationButtonWithImage() {
        let setButton = UIBarButtonItem(
            barButtonSystemItem: .refresh, target: self, action: Selector("naviButtonClick:")
        )
        setButton.isEnabled = true
        self.navigationItem.rightBarButtonItem = setButton
    }
    
    //导航栏按钮按下
    override func naviButtonClick(button: UIBarButtonItem) {
        super.naviButtonClick(button: button)
        
        webView.reload()
    }
}
