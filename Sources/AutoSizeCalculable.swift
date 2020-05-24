#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol AutoSizeCalculable {
    var autoSizingRect: CGRect? { get set }
    var autoSizingRectWithMargins: CGRect? { get set }

    func autoSizeThatFits(_ size: CGSize, layoutClosure: () -> Void) -> CGSize
}
