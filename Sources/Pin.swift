//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

@objc public enum LayoutDirection: Int {
    case auto
    case ltr
    case rtl
}

/// Control how PinLayout will calls `UIView.safeAreaInsetsDidChange` when the `UIView.pin.safeArea` change.
/// This support is usefull only on iOS 8/9/10. On iOS 11 `UIView.safeAreaInsetsDidChange` is supported
/// natively so this settings have no impact.
@objc public enum PinSafeAreaInsetsDidChangeMode: Int {
    /// PinLayout won't call `UIView.safeAreaInsetsDidChange` on iOS 8/9/10.
    case disable
    /// PinLayout will call `UIView.safeAreaInsetsDidChange` only if the UIView implement the PinSafeAreaInsetsUpdate protocol.
    case optIn
    /// PinLayout will automatically calls `UIView.safeAreaInsetsDidChange` if the view has implemented this method.
    case always
}

@objc public class Pin: NSObject {
    @objc public static var layoutDirection = LayoutDirection.ltr

    #if os(iOS) || os(tvOS)
    /// Controls how PinLayout will calls `UIView.safeAreaInsetsDidChange` when the `UIView.pin.safeArea` change.
    @objc public static var safeAreaInsetsDidChangeMode: PinSafeAreaInsetsDidChangeMode = .optIn {
        didSet {
            PinSafeArea.safeAreaInsetsDidChangeMode = safeAreaInsetsDidChangeMode
        }
    }
    #endif


#if DEBUG
    @objc public static var logWarnings = true
#else
    @objc public static var logWarnings = false
#endif
    
    /**
     If your codes need to work in Xcode playgrounds, you may set to `true` the property
     `Pin.logMissingLayoutCalls`, this way any missing call to `layout()` will generate
     a warning in the Xcode console..
    */
    @objc public static var logMissingLayoutCalls = false

    static fileprivate var isInitialized = false

    @objc public static func initPinLayout() {
        #if os(iOS) || os(tvOS)
        guard !Pin.isInitialized else { return }
        PinSafeArea.initSafeAreaSupport()
        Pin.isInitialized = true
        #endif
    }

    @objc public static func layoutDirection(_ direction: LayoutDirection) {
        self.layoutDirection = direction
    }

    // Contains PinLayout last warning's text. Used by PinLayout's Unit Tests.
    @objc public static var lastWarningText: String?
}
