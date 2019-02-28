//  Copyright (c) 2018 Luc Dion
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

/*
 UIView's anchors point
 ======================

 topLeft      topCenter       topRight
 o-------------o--------------o
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 |           center           |
 centerLeft o             o              o centerRight
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 o-------------o--------------o
 bottomLeft    bottomCenter     bottomLeft

 */

/// UIViews's anchor definition
@objc public protocol Anchor {
}

/// UIViews's list of anchors.
@objc public protocol AnchorList {
    var topLeft: Anchor { get }
    var topCenter: Anchor { get }
    var topRight: Anchor { get }
    var centerLeft: Anchor { get }
    var center: Anchor { get }
    var centerRight: Anchor { get }
    var bottomLeft: Anchor { get }
    var bottomCenter: Anchor { get }
    var bottomRight: Anchor { get }

    // RTL support
    var topStart: Anchor { get }
    var topEnd: Anchor { get }
    var centerStart: Anchor { get }
    var centerEnd: Anchor { get }
    var bottomStart: Anchor { get }
    var bottomEnd: Anchor { get }
}

/*
 UIView's Edges
 ======================
 top
 +-----------------+
 |                 |
 |                 |
 |     hCenter     |
 left |        +        | right
 |     vCenter     |
 |                 |
 |                 |
 +-----------------+
 bottom
 */

/// UIViews's list of edges
@objc public protocol EdgeList {
    var top: VerticalEdge { get }
    var vCenter: VerticalEdge { get }
    var bottom: VerticalEdge { get }
    var left: HorizontalEdge { get }
    var hCenter: HorizontalEdge { get }
    var right: HorizontalEdge { get }

    // RTL support
    var start: HorizontalEdge { get }
    var end: HorizontalEdge { get }
}

/// Horizontal alignment used with relative positioning methods: above(of relativeView:, aligned:), below(of relativeView:, aligned:), ...
///
/// - left: left aligned
/// - center: center aligned
/// - right: right aligned
@objc public enum HorizontalAlign: Int {
    /// The view's left edge will be left-aligned with the relative view (or the left most view if a list of relative views is specified).
    case left
    /// The view's will be horizontally centered with the relative view (or the average hCenter if a list of relative views is used).
    case center
    /// The view's right edge will be right-aligned with the relative view (or the right most view if a list of relative views is specified).
    case right
    /// No alignment will be applied.
    case none
    // RTL support
    /// In LTR direction, similar to using HorizontalAlignment.left.
    /// In RTL direction, similar to using HorizontalAlignment.right.
    case start
    /// In LTR direction, similar to using HorizontalAlignment.right.
    /// In RTL direction, similar to using HorizontalAlignment.left.
    case end
}

/// Vertical alignment used with relative positioning methods: after(of relativeView:, aligned:), before(of relativeView:, aligned:), ...
///
/// - top: top aligned
/// - center: center aligned
/// - bottom: bottom aligned
@objc public enum VerticalAlign: Int {
    /// The view's top edge will be top-aligned with the relative view (or the top most view if a list of relative views is specified).
    case top
    /// The view's will be vertically centered with the relative view (or the average vCenter if a list of relative views is used).
    case center
    /// The view's bottom edge will be bottom-aligned with the relative view (or the bottom most view if a list of relative views is specified).
    case bottom
    /// No alignment will be applied.
    case none
}

/// UIView's horizontal edges (left/right) definition
@objc public protocol HorizontalEdge {
}

/// UIView's vertical edges (top/bottom) definition
@objc public protocol VerticalEdge {
}

public enum FitType {
    /**
     **Adjust the view's height** based on the reference width.
     * If properties related to the width have been pinned (e.g: width, left & right, margins),
     the **reference width will be determined by these properties**, else the **current view's width**
     will be used.
     * The resulting width will always **match the reference width**.
     */
    case width
    /**
     **Adjust the view's width** based on the reference height.
     * If properties related to the height have been pinned (e.g: height, top & bottom, margins),
     the reference height will be determined by these properties, else the **current view's height**
     will be used.
     * The resulting height will always **match the reference height*.
     */
    case height

    /**
     Similar to `.width`, except that PinLayout won't constrain the resulting width to
     match the reference width. The resulting width may be smaller of bigger depending on the view's
     sizeThatFits(..) method result. For example a single line UILabel may returns a smaller width if its
     string is smaller than the reference width.
     */
    case widthFlexible
    /**
     Similar to `.height`, except that PinLayout won't constrain the resulting height to
     match the reference height. The resulting height may be smaller of bigger depending on the view's
     sizeThatFits(..) method result.
     */
    case heightFlexible

    /**
     Adjust the view's size based on it's content size requirements so that it uses the
     most appropriate amount of space. This fit type has the same effect as calling **sizeToFit()** on a view.
     The resulting size come from sizeThatFits(..) being called with the current view bounds.
     */
    case content
}

@objc public enum WrapType: Int {
    /// Adjust the view's width AND height to wrap all its subviews.
    case all
    /// Adjust only the view's width to wrap all its subviews. The view's height won't be modified.
    case horizontally
    /// Adjust only the view's height to wrap all its subviews. The view's width won't be modified.
    case vertically
}

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
