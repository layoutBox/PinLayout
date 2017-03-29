// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import UIKit

public extension UIView {
    public var pin: PinLayout {
        return PinLayoutImpl(view: self)
    }

    public var anchor: PinList {
        return PinList(view: self)
    }

    public var edge: EdgeList {
        return EdgeList(view: self)
    }
}

public protocol PinLayout {
    @discardableResult func top(_ value: CGFloat) -> PinLayout
    @discardableResult func left(_ value: CGFloat) -> PinLayout
    @discardableResult func bottom(_ value: CGFloat) -> PinLayout
    @discardableResult func right(_ value: CGFloat) -> PinLayout

    @discardableResult func top(to edge: VerticalEdge) -> PinLayout
    @discardableResult func left(to edge: HorizontalEdge) -> PinLayout
    @discardableResult func bottom(to edge: VerticalEdge) -> PinLayout
    @discardableResult func right(to edge: HorizontalEdge) -> PinLayout
    
    @discardableResult func topLeft(to point: CGPoint) -> PinLayout
    @discardableResult func topLeft(to pin: Pin) -> PinLayout
    @discardableResult func topLeft() -> PinLayout

    @discardableResult func topCenter(to point: CGPoint) -> PinLayout
    @discardableResult func topCenter(to pin: Pin) -> PinLayout
    @discardableResult func topCenter() -> PinLayout

    @discardableResult func topRight(to point: CGPoint) -> PinLayout
    @discardableResult func topRight(to pin: Pin) -> PinLayout
    @discardableResult func topRight() -> PinLayout

    @discardableResult func leftCenter(to point: CGPoint) -> PinLayout
    @discardableResult func leftCenter(to pin: Pin) -> PinLayout
    @discardableResult func leftCenter() -> PinLayout

    @discardableResult func center(to point: CGPoint) -> PinLayout
    @discardableResult func center(to pin: Pin) -> PinLayout
    @discardableResult func center() -> PinLayout

    @discardableResult func rightCenter(to point: CGPoint) -> PinLayout
    @discardableResult func rightCenter(to pin: Pin) -> PinLayout
    @discardableResult func rightCenter() -> PinLayout

    @discardableResult func bottomLeft(to point: CGPoint) -> PinLayout
    @discardableResult func bottomLeft(to pin: Pin) -> PinLayout
    @discardableResult func bottomLeft() -> PinLayout

    @discardableResult func bottomCenter(to point: CGPoint) -> PinLayout
    @discardableResult func bottomCenter(to pin: Pin) -> PinLayout
    @discardableResult func bottomCenter() -> PinLayout

    @discardableResult func bottomRight(to point: CGPoint) -> PinLayout
    @discardableResult func bottomRight(to pin: Pin) -> PinLayout
    @discardableResult func bottomRight() -> PinLayout

    @discardableResult func above(of relativeView: UIView) -> PinLayout
    @discardableResult func above(of relativeView: UIView, aligned: HorizontalAlignment) -> PinLayout
    @discardableResult func below(of relativeView: UIView) -> PinLayout
    @discardableResult func below(of relativeView: UIView, aligned: HorizontalAlignment) -> PinLayout
    @discardableResult func left(of relativeView: UIView) -> PinLayout
    @discardableResult func left(of relativeView: UIView, aligned: VerticalAlignment) -> PinLayout
    @discardableResult func right(of relativeView: UIView) -> PinLayout
    @discardableResult func right(of relativeView: UIView, aligned: VerticalAlignment) -> PinLayout

    @discardableResult func width(_ width: CGFloat) -> PinLayout
    @discardableResult func width(percent: CGFloat) -> PinLayout
    @discardableResult func width(of view: UIView) -> PinLayout
    @discardableResult func height(_ height: CGFloat) -> PinLayout
    @discardableResult func height(percent: CGFloat) -> PinLayout
    @discardableResult func height(of view: UIView) -> PinLayout
    @discardableResult func size(_ size: CGSize) -> PinLayout
    @discardableResult func size(of view: UIView) -> PinLayout
    @discardableResult func sizeToFit() -> PinLayout

    @discardableResult func margin(_ value: CGFloat) -> PinLayout
    @discardableResult func marginHorizontal(_ value: CGFloat) -> PinLayout
    @discardableResult func marginVertical(_ value: CGFloat) -> PinLayout
    @discardableResult func marginTop(_ value: CGFloat) -> PinLayout
    @discardableResult func marginLeft(_ value: CGFloat) -> PinLayout
    @discardableResult func marginBottom(_ value: CGFloat) -> PinLayout
    @discardableResult func marginRight(_ value: CGFloat) -> PinLayout

    @discardableResult func inset(_ value: CGFloat) -> PinLayout
    @discardableResult func insetTop(_ value: CGFloat) -> PinLayout
    @discardableResult func insetLeft(_ value: CGFloat) -> PinLayout
    @discardableResult func insetBottom(_ value: CGFloat) -> PinLayout
    @discardableResult func insetRight(_ value: CGFloat) -> PinLayout
    @discardableResult func insetHorizontal(_ value: CGFloat) -> PinLayout
    @discardableResult func insetVertical(_ value: CGFloat) -> PinLayout
}

// RELATIVE POSITION
public enum HorizontalAlignment: String {
    case left
    case center
    case right
}

public enum VerticalAlignment: String {
    case top
    case center
    case bottom
}


