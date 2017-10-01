
extension UILabel {

    //根据字号和内容和宽度计算高度
    static func calculateHeight(content: String, width: CGFloat, fontsize: CGFloat) -> CGFloat {
        let testLabel = UILabel()
        testLabel.font = UIFont.systemFont(ofSize: fontsize)
        testLabel.lineBreakMode = .byCharWrapping
        testLabel.text = content
        testLabel.frame = CGRect(
            origin: testLabel.frame.origin, size: CGSize(width: max(width, 0), height: 0)
        )
        testLabel.numberOfLines = 0
        testLabel.sizeToFit()
        return testLabel.frame.height
    }

    static func calculateWidth(content: String, fontsize: CGFloat) -> CGFloat {
        let testLabel = UILabel()
        testLabel.font = UIFont.systemFont(ofSize: fontsize)
        testLabel.text = content
        testLabel.frame = CGRect(origin: testLabel.frame.origin,size: CGSize.zero)
        testLabel.numberOfLines = 1
        testLabel.sizeToFit()
        return testLabel.frame.width
    }

    static func calculateSize(content: String, fontsize: CGFloat) -> CGSize {
        let testLabel = UILabel()
        testLabel.font = UIFont.systemFont(ofSize: fontsize)
        testLabel.text = content
        testLabel.frame = CGRect(origin: testLabel.frame.origin,size: CGSize.zero)
        testLabel.numberOfLines = 1
        testLabel.sizeToFit()
        return testLabel.frame.size
    }
}
