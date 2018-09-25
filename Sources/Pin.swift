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

    static private var isInitialized = false

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

    //
    // Warnings
    //
    #if DEBUG
        @objc public static var logWarnings = true
    #else
        @objc public static var logWarnings = false
    #endif

    @objc public static var activeWarnings = ActiveWarnings()

    /**
     If your codes need to work in Xcode playgrounds, you may set to `true` the property
     `Pin.logMissingLayoutCalls`, this way any missing call to `layout()` will generate
     a warning in the Xcode console..
     */
    @objc public static var logMissingLayoutCalls = false

    // Contains PinLayout last warning's text. Used by PinLayout's Unit Tests.
    @objc public static var lastWarningText: String?

    public static func resetWarnings() {
    #if DEBUG
        logWarnings = true
    #endif
        activeWarnings = ActiveWarnings()
    }
}

@objc public class ActiveWarnings: NSObject {
    /// When set to true, a warning is displayed if there is no space available between views
    /// specified in a call to `horizontallyBetween(...)` or `verticallyBetween(...)`.
    public var noSpaceAvailableBetweenViews = true

    /// When set to true, a warning is displayed if 'aspectRatio()' is called on a UIImageView without a valid UIImage.
    public var aspectRatioImageNotSet = true
}
