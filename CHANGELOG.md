<p align="center">
	<img src="docs/pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout</h1>


# Change Log

## [1.8.10](https://github.com/layoutBox/PinLayout/releases/tag/1.8.10)
Released on 2019-09-16

#### Usage `UIView.effectiveUserInterfaceLayoutDirection` to detect RTL

* Use `UIView.effectiveUserInterfaceLayoutDirection` to detect RTL on iOS 10 and above. This is recommended approach to detect layout direction taking into account view's semantic content attribute, trait environment and UIApplication layout direction.
	* Added by [MontakOleg](https://github.com/MontakOleg) in Pull Request [#200](https://github.com/layoutBox/PinLayout/pull/200) 
* Update Travis to Xcode 11.
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#202](https://github.com/layoutBox/PinLayout/pull/202) 


## [1.8.9](https://github.com/layoutBox/PinLayout/releases/tag/1.8.9)
Released on 2019-08-16

#### Upgrade to Swift 5 

* Upgrade project to Swift 5
* Update Pods
* Apply xcodeproj migration

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#195](https://github.com/layoutBox/PinLayout/pull/195) 


## [1.8.8](https://github.com/layoutBox/PinLayout/releases/tag/1.8.8)
Released on 2019-06-25

#### Update Swift Package Manager support for Xcode 11 

* Updated PinLayout to be used with Xcode 11's Swift Package Manager.
    * Added by [Hal Lee](https://github.com/hallee) in Pull Request [#192](https://github.com/layoutBox/PinLayout/pull/192) 
 
* Fix Warnings: `public' modifier is redundant for instance method declared in a public extension`.
    * Added by [MontakOleg](https://github.com/MontakOleg) in Pull Request [#193](https://github.com/layoutBox/PinLayout/pull/193) 

## [1.8.7](https://github.com/layoutBox/PinLayout/releases/tag/1.8.7)
Released on 2019-03-02

#### Add missing Objective-C API methods

* wrapContent
* wrapContentWithPadding:(CGFloat)
* wrapContentWithInsets:(PEdgeInsets)
* wrapContentWithType:(WrapType)
* wrapContentWithType:(WrapType) padding:(CGFloat)
* wrapContentWithType:(WrapType) insets:(PEdgeInsets)

## [1.8.6](https://github.com/layoutBox/PinLayout/releases/tag/1.8.6)
Released on 2018-09-29

#### Update support for Swift 4.2
The PinLayout pod doesn't specify anymore the Swift language version. 

PinLayout supports Swift versions:
* Swift 4.2 / 4.1 / 4.0
* Swift 3.*

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#178](https://github.com/layoutBox/PinLayout/pull/178) 


## [1.8.5](https://github.com/layoutBox/PinLayout/releases/tag/1.8.5)
Released on 2018-09-27

#### Minor internal changes
Remove `sizeToFit()` from SizeCalculable protocol. 
This change ensure that PinLayout `pin.sizeToFit()` method behave correctly. As per the iOS documentation, we should not directly override sizeToFit() but rather always only implement sizeThatFits(_:) for auto-sizing needs. This update aim to remove the sizeToFit() requirement in the SizeCalculable protocol.

* Added by [Antoine Lamy](https://github.com/antoinelamy) in Pull Request [#164](https://github.com/layoutBox/PinLayout/pull/164) 


## [1.8.4](https://github.com/layoutBox/PinLayout/releases/tag/1.8.4)
Released on 2018-09-25

#### Minor changes

* Cleanup .xcodeproj
* Removed Swiftlint warnings
* Fix an issue with PinLayoutSample app related to IntroRTLView example

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#177](https://github.com/layoutBox/PinLayout/pull/177) 

## [1.8.3](https://github.com/layoutBox/PinLayout/releases/tag/1.8.3)
Released on 2018-08-28

#### Add methods to layout a view between two other views
Add methods to position a view between two other views, either horizontally or vertically. 

**New Methods:**

* **`horizontallyBetween(:UIView, and: UIView)`**  
Position the view between the two specified views horizontally. The method layout the view's left and right edges. The order of the reference views is irrelevant.
Note that the layout will be applied only if there is horizontal space between the specified views. 

* **`horizontallyBetween(:UIView, and: UIView, aligned: VerticalAlign)`**  
Position the view between the two specified views horizontally and aligned it using the specified VerticalAlign. The view will be aligned related to the first specified reference view. Note that the layout will be applied only if there is horizontal space between the specified views. 

* **`verticallyBetween(:UIView, and: UIView)`**  
Position the view between the two specified views vertically. The method layout the view's top and bottom edges. The order of the reference views is irrelevant. Note that the layout will be applied only if there is vertical space between the specified views. 

* **`verticallyBetween(:UIView, and: UIView, aligned: HorizontalAlign)`**  
Position the view between the two specified views vertically and aligned it using the specified HorizontalAlign. The view will be aligned related to the first specified reference view. Note that the layout will be applied only if there is vertical space between the specified views. 

###### Example:

<img src="docs/images/pinlayout_verticallyBetween.png" width="600"/>

```swift
   view.pin.verticallyBetween(viewA, and: viewB, aligned: .center).marginVertical(10)
```

See [Readme for more information](https://github.com/layoutBox/PinLayout#layout_between)


* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#172](https://github.com/layoutBox/PinLayout/pull/172) 

## [1.8.2](https://github.com/layoutBox/PinLayout/releases/tag/1.8.2)
Released on 2018-08-25

#### Add `pin.readableMargins` and `pin.layoutmargins`
Add properties: 

* **`pin.readableMargins: UIEdgeInset`**:  
PinLayout's `UIView.pin.readableMargins` property expose UIKit [`UIView.readableContentGuide`](https://developer.apple.com/documentation/uikit/uiview/1622644-readablecontentguide) as an UIEdgeInsets. This is really useful since UIKit only expose the readableContent area to Auto Layout using UILayoutGuide.

* **`pin.layoutmargins: UIEdgeInset`**  
PinLayout's `UIView.pin.layoutMargins` property expose directly the value of UIKit [`UIView.layoutMargins`](https://developer.apple.com/documentation/uikit/uiview/1622566-layoutmargins). The property exists only to be consistent with the other areas: `pin.safeArea`, `pin.readableMargins` and `pin.layoutmargins`. So its usage is not necessary.

**Add examples using these properties:**
![pinlayout_example_layout_margins_all](https://user-images.githubusercontent.com/14981341/44617938-51475900-a83a-11e8-96eb-d24f5561dab2.png)

![pinlayout_example_tableview_readable_content_all](https://user-images.githubusercontent.com/14981341/44617939-51475900-a83a-11e8-9cc6-fe2aac499ce8.png)

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#170](https://github.com/layoutBox/PinLayout/pull/170) 

## [1.8.1](https://github.com/layoutBox/PinLayout/releases/tag/1.8.1)
Released on 2018-08-23

#### PinLayout Swift 3 support
PinLayout supports Swift 3 and Swift 4

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#169](https://github.com/layoutBox/PinLayout/pull/169) 


## [1.8.0](https://github.com/layoutBox/PinLayout/releases/tag/1.8.0)
Released on 2018-08-21

#### Deprecated method `fitSize()` has been removed
`fitSize()` has been removed after being deprecated for 10 months. `sizeToFit(:FitType)` should now be used instead. See [Adjusting size](https://github.com/layoutBox/PinLayout#adjusting_size).

Plus:

* Refactor relative positioning methods source code (above(...), after(...), ...) using a default parameter value for the alignment parameter.
* Fix unit test screen density.
* Update few examples source code.


* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#167](https://github.com/layoutBox/PinLayout/pull/167) 


## [1.7.12](https://github.com/layoutBox/PinLayout/releases/tag/1.7.12)
Released on 2018-08-16

#### Add Animations documentation and example
Add documentation that explains how PinLayout can handle view's animations.

* Show few strategies that can be used to animate views.
* Add an Animation example in the Example app.
* Add an new "Examples" markdown page showing all PinLayout's examples.
* Convert `fileprivate` to `private` declarations

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#165](https://github.com/layoutBox/PinLayout/pull/165) 


## [1.7.11](https://github.com/layoutBox/PinLayout/releases/tag/1.7.11)
Released on 2018-08-05

#### Method that position multiple edges now accept an `offset` parameter.
The `offset` parameter that specifies the distance from their superview's corresponding edges in pixels.

**New methods:**

* `topLeft(_ offset: CGFloat)`
* `topCenter(_ topOffset: CGFloat)`
* `topRight(_ offset: CGFloat)`

* `centerLeft(_ leftOffset: CGFloat)`
* `center(_ offset: CGFloat)`
* `centerRight(_ rightOffset offset: CGFloat)`

* `bottomLeft(_ offset: CGFloat)`
* `bottomCenter(_ bottomOffset: CGFloat)`
* `bottomRight(_ offset: CGFloat)`

For example, to position a view at the top left corner with a top and left margin of 10 pixels:

```
   view.pin.topLeft(10)
```

#### Other change
Cleanup the interface by using default value parameters.

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#163](https://github.com/layoutBox/PinLayout/pull/163) 


## [1.7.10](https://github.com/layoutBox/PinLayout/releases/tag/1.7.10)
Released on 2018-07-17

#### Add `sizeToFit()` method.
The method adjust the view's size based on the result of the method `UIView.sizeToFit()`. Particularly useful for controls/views that have an intrinsic size (label, button, ...).

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#158](https://github.com/layoutBox/PinLayout/pull/158) 


## [1.7.9](https://github.com/layoutBox/PinLayout/releases/tag/1.7.9)
Released on 2018-06-28

#### Fix a regression
The recent changes to PinLayout that enable the layout of CALayer has impacted the layout of UIViews.

* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#152](https://github.com/layoutBox/PinLayout/pull/152) 


## [1.7.8](https://github.com/layoutBox/PinLayout/releases/tag/1.7.8)
Released on 2018-06-26

#### Add support for CALayer layout
PinLayout can now layouts **CALayer**'s. All PinLayout's properties and methods are available, with the following exceptions:

* `sizeToFit(:FitType)` is not supported. Support for `sizeToFit(:FitType)` can be added to your custom CALayer subclasses, just make those layers conform to the `SizeCalculable` protocol and implement the two required functions.
* `CALayer.pin.safeArea` property is not available.
* `aspectRatio()` with no parameters

See [CALayer Support documentation](https://github.com/layoutBox/PinLayout#calayer-support) for more information

* Added by [Antoine Lamy](https://github.com/antoinelamy) in Pull Request [#151](https://github.com/layoutBox/PinLayout/pull/151) 


## [1.7.7](https://github.com/layoutBox/PinLayout/releases/tag/1.7.6)
Released on 2018-06-19

#### Refactoring using generics
Refactoring to avoid having to deal directly with view types, making it easier to extend layouting to other APIs (e.g: CALayer)

* Added by [Antoine Lamy](https://github.com/antoinelamy) in Pull Request [#148](https://github.com/layoutBox/PinLayout/pull/148) 


## [1.7.6](https://github.com/layoutBox/PinLayout/releases/tag/1.7.6)
Released on 2018-06-12

### PinLayout has moved to the **layoutBox** organization
PinLayout is now part of the same organization as other open source projects related to layout using Swift.

#### Refactor source code that handle size adjustment.
* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#143](https://github.com/layoutBox/PinLayout/pull/143) 

#### Add an example using `wrapContent()` methods
* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#145](https://github.com/layoutBox/PinLayout/pull/145) 

#### Refactor views frame/bounds access
* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#147](https://github.com/layoutBox/PinLayout/pull/147) 



## [1.7.5](https://github.com/layoutBox/PinLayout/releases/tag/1.7.5)
Released on 2018-06-05

### Add `wrapContent()` methods that adjust view's width & height to wrap all its subviews

The following methods are useful to adjust view's width and/or height to wrap all its subviews. These methods also adjust subviews position to create a tight wrap.

**Methods:**

* **`wrapContent()`**  
**`wrapContent(padding: CGFloat)`**  
**`wrapContent(padding: UIEdgeInsets)`**   
Adjust the view's width and height to wrap all its subviews. The method also adjusts subviews position to create a tight wrap. It is also possible to specify an optional padding around all subviews. 
* **`wrapContent(:WrapType)`**  
**`wrapContent(:WrapType, padding: CGFloat)`**  
**`wrapContent(:WrapType, padding: UIEdgeInsets)`**   
Adjust the view's width AND/OR height to wrap all its subviews. WrapType values are `.horizontally`/`.vertically`/`.all` It is also possible to specify an optional padding around all subviews. 

See [documentation](https://github.com/layoutBox/PinLayout#wrapContent) for more information

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#141](https://github.com/layoutBox/PinLayout/pull/141) 


## [1.7.4](https://github.com/layoutBox/PinLayout/releases/tag/1.7.4)
Released on 2018-05-26

### Objective-C support for macOS and tvOS
Add the support of Objective-C to macOS and tvOS.

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#138](https://github.com/layoutBox/PinLayout/pull/138) 

## [1.7.3](https://github.com/layoutBox/PinLayout/releases/tag/1.7.3)
Released on 2018-04-25

### Add few missing Objective-C Interface properties and methods
These methods and properties are now accessible from Objective-C:
* `Pin.layoutDirection`
* `Pin.safeAreaInsetsDidChangeMode`
* `Pin.logWarnings`
* `Pin.initPinLayout()`
* `Pin.layoutDirection()`

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#135](https://github.com/layoutBox/PinLayout/pull/135) 


## [1.7.2](https://github.com/layoutBox/PinLayout/releases/tag/1.7.2)
Released on 2018-04-23

### Fine tune UIView.pin.safeArea support for iOS 8 and "New Relic" framework
Changes:

* On iOS 8, PinLayout compatibility support of UIView.safeAreaInsetsDidChange was causing issues with the device's virtual keyboard. PinLayout still support UIView.pin.safeArea on this iOS release, but UIView.safeAreaInsetsDidChange won't be called on iOS 8

* Fix issue with "New Relic" framework: Add a Pin.initPinLayout() that can be called to initialize PinLayout before the "New Relic" framework is initialized. "New Relic" is conflicting with other popular frameworks including Mixpanel, ReactiveCocoa, Aspect, ..., and PinLayout. To fix the issue, `Pin.initPinLayout()` must be called BEFORE initializing "New Relic" with `NewRelic.start(withApplicationToken:"APP_TOKEN")`. See here for more information regarding this issue #130

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#134](https://github.com/layoutBox/PinLayout/pull/134) 



## [1.7.0](https://github.com/layoutBox/PinLayout/releases/tag/1.7.0)
Released on 2018-04-20

### Add macOS support
PinLayout now support macOS.

PinLayout **support of macOS is not complete at 100%**, see here the particularities of the current implementation:

* PinLayout support **only views that have a parent (superview) using a flipped coordinate system**, i.e. views for which  the computed property `var isFlipped: Bool` returns true. In a flipped coordinate system, the origin is in the upper-left corner of the view and y-values extend downward. UIKit use this coordinate system. In a non-flipped coordinate system (default mode), the origin is in the lower-left corner of the view and positive y-values extend upward. See [Apple's documentation for more information about `NSView.isFlipped`](https://developer.apple.com/documentation/appkit/nsview/1483532-isflipped). The support of non-flipped coordinate system will be added soon.

* These methods are currently not supported on macOS, but they will be implemented soon:

	* `sizeToFit(:FitType)` (Coming soon)
	* `aspectRatio()` with no parameters (Coming soon)

* `UIView.pin.safeArea` property is not available, AppKit doesn't have an UIView.safeAreaInsets equivalent.

All other PinLayout's methods and properties are available on macOS!

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#131](https://github.com/layoutBox/PinLayout/pull/131) 


### PinLayout now use MIT license
The PinLayout license has been changed from **BSD 3-clause "New"** to **MIT License**.

## [1.6.0](https://github.com/layoutBox/PinLayout/releases/tag/1.6.0)
Released on 2018-03-22

### UIView.pin.safeArea
PinLayout can handle easily iOS 11 UIView.safeAreaInsets, but it goes further by supporting safeAreaInsets for previous iOS releases (including iOS 7/8/9/10) by adding a property UIView.pin.safeArea. PinLayout also extend the support of UIView.safeAreaInsetsDidChange() callback on iOS 7/8/9/10.  

See [UIView.pin.safeArea Documentation](https://github.com/layoutBox/PinLayout#safeAreaInsets) for more details.

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#125](https://github.com/layoutBox/PinLayout/pull/125) 


### Add methods taking UIEdgeInset as parameter
* `all(_ insets: UIEdgeInsets)`
* `horizontally(_ insets: UIEdgeInsets)`
* `vertically(_ insets: UIEdgeInsets)`
* `top(_ insets: UIEdgeInsets)`
* `bottom(_ insets: UIEdgeInsets)`
* `left(_ insets: UIEdgeInsets)`
* `right(_ insets: UIEdgeInsets)`

	See [Layout using distances from superview’s edges](https://github.com/layoutBox/PinLayout#layout-using-distances-from-superviews-edges) for more details.

	Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#125](https://github.com/layoutBox/PinLayout/pull/125) 

### Add margins method with percentage parameter

* `marginTop(_ percent: Percent)`
* `marginLeft(_ percent: Percent)`
* `marginBottom(_ percent: Percent)`
* `marginLeft(_ percent: Percent)`
* `marginStart(_ percent: Percent)`
* `marginEnd(_ percent: Percent)`
* `marginHorizontal(_ percent: Percent)`
* `marginVertical(_ percent: Percent)`
* `margin(_ percent: Percent)`
* `margin(_ vertical: Percent, _ horizontal: Percent)`
* `margin(_ top: Percent, _ horizontal: Percent, _ bottom: Percent)`
* `margin(_ top: Percent, _ left: Percent, _ bottom: Percent, _ right: Percent)`

	Added by [vandyshev](https://github.com/vandyshev) in Pull Request [#126](https://github.com/layoutBox/PinLayout/pull/126) 

## [1.5.9](https://github.com/layoutBox/PinLayout/releases/tag/1.5.9)
Released on 2018-02-18

#### **`UIView.pin`** versus **`UIView.pinFrame`**
Until now `UIView.pin` was used to layout views, but there's also another property called `UIView.pinFrame` that does something slightly different in situations where the view has a transform (`UIView.transform`, scaling, rotation, ...).

* `pin`: Set the position and the size of the **non-transformed view**. The size and position is applied **before the transform**. This is particularly useful when you want to animate a view using a transform without modifying its layout.

* `.pinFrame`: Set the position and the size on the **transformed view**. The size and position is applied **after the transform**.

See https://github.com/layoutBox/PinLayout#uiviews-transforms for more informations.

Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#122](https://github.com/layoutBox/PinLayout/pull/122) 


## [1.5.8](https://github.com/layoutBox/PinLayout/releases/tag/1.5.8)
Released on 2018-01-20

* Handle layout relative to a view with a transform and/or a modified anchorPoint.  
Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#116](https://github.com/layoutBox/PinLayout/pull/116) 

## [1.5.7](https://github.com/layoutBox/PinLayout/releases/tag/1.5.7)
Released on 2018-01-19

* Fix an issue that was affecting UIScrollViews. PinLayout now set only the bounds's size and keep the origin.  
Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#115](https://github.com/layoutBox/PinLayout/pull/115) 

* Handle correctly view's `layer.anchorPoint`. PinLayout now update correctly the view position when the view's layer.anchorPoint has been modified, i.e. when it is not its default value (0.5, 0.5).
Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#114](https://github.com/layoutBox/PinLayout/pull/114) 

## [1.5.5](https://github.com/layoutBox/PinLayout/releases/tag/1.5.5)
Released on 2018-01-12

Add methods:

* **`all(_ value: CGFloat)`**  
The value specifies the **top, bottom, left and right edges** distance from the superview's corresponding edge in pixels. 
Similar to calling `view.top(value).bottom(value).left(value).right(value)`. 

* **`horizontally(_ value: CGFloat)`** / **`horizontally(_ percent: Percent)`** 
The value specifies the **left and right edges** on its superview's corresponding edges in pixels (or in percentage of its superview's width).  
Similar to calling `view.left(value).right(value)`. 

* **`vertically(_ value: CGFloat)`**  / **`vertically(_ percent: Percent)`** 
The value specifies the ** top and bottom edges** on its superview's corresponding edges in pixels (or in percentage of its superview's height).  
Similar to calling `view.top(value).bottom(value)`. 
	* Added by [Olivier Pineau](https://github.com/OlivierPineau) in Pull Request [#111](https://github.com/layoutBox/PinLayout/pull/111) 

## [1.5.4](https://github.com/layoutBox/PinLayout/releases/tag/1.5.4)
Released on 2017-12-28

* PinLayout now handle correctly more situations with view with transforms.
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#110](https://github.com/layoutBox/PinLayout/pull/110) 


## [1.5.3](https://github.com/layoutBox/PinLayout/releases/tag/1.5.3)
Released on 2017-12-28

* PinLayout now handle correctly parents (superviews) with transforms.
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#108](https://github.com/layoutBox/PinLayout/pull/108) 


## [1.5.2](https://github.com/layoutBox/PinLayout/releases/tag/1.5.2)
Released on 2017-12-22

* POSSIBLE BREAKING CHANGE: PinLayout now keeps UIView's transform (scale, rotation, ...)    
Previously any view's transform was altered after layouting the view with PinLayout. Now PinLayout won't affect the view's transforms.  

	For people not using transforms, this should be a non-breaking change. If someone is using transforms with PinLayout, this may change the behavior, although I think this will produce the expected results (ie, transforms not being affected/altered by layout).
  
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#107](https://github.com/layoutBox/PinLayout/pull/107) 


## [1.5.1](https://github.com/layoutBox/PinLayout/releases/tag/1.5.1)

#### Change

* Add `layout()` method to support Xcode playgrounds
PinLayout layouts views immediately after the line containing `.pin` has been fully executed, thanks to ARC (Automatic Reference Counting) this works perfectly on iOS/tvOS/macOS simulators and devices. But in Xcode Playgrounds, ARC doesn't work as expected, object references are kept much longer. This is a well-documented issue. The impact of this problem is that PinLayout doesn't layout views at the time and in the order required. To handle this situation in playgrounds it is possible to call the `layout()` method to complete the layout.

[See PinLayout in Xcode Playgrounds documentation for more information](https://github.com/layoutBox/PinLayout#playgrounds)
	
* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#101](https://github.com/layoutBox/PinLayout/pull/101)
	

## [1.5.0](https://github.com/layoutBox/PinLayout/releases/tag/1.5.0)
### New method `sizeToFit(:FitType)` & `fitSize()` is now deprecated

#### Changes

* BREAKING CHANGE: **`fitSize()`** is now deprecated. The new `sizeToFit(:FitType)` should be used instead.

* New method **`sizeToFit(_ fitType: FitType)`**  
	* **`sizeToFit(_ fitType: FitType)`**  
	The method adjust the view's size based on the view's `sizeThatFits()` method result.
	     PinLayout will adjust either the view's width or height based on the `fitType` parameter value.
	     
	     Notes:
	     * If margin rules apply, margins will be applied when determining the reference dimension (width/height).
	     * The resulting size will always respect `minWidth` / `maxWidth` / `minHeight` / `maxHeight`.
	     
		**Parameter `fitType`:** Identify the reference dimension (width / height) that will be used to adjust the view's size.  
	
	 * **`.width`**: The method adjust the view's size based on the **reference width**.
	        * If properties related to the width have been pinned (e.g: width, left & right, margins, ...), the **reference width will be determined by these properties**, if not the **current view's width** will be used.
	        * The resulting width will always **match the reference width**.
	     
	 * **`.height`**: The method adjust the view's size based on the **reference height**.
	         * If properties related to the height have been pinned (e.g: height, top & bottom, margins, ...), the **reference height will be determined by these properties**, if not the **current view's height**  will be used.
	         * The resulting height will always **match the reference height**.
	     
	 * **`.widthFlexible`**: Similar to `.width`, except that PinLayout won't constrain the resulting width to match the reference width. The resulting width may be smaller of bigger depending on the view's sizeThatFits(..) method result. For example a single line UILabel may returns a smaller width if its string is smaller than the reference width.
	     
	 * **`.heightFlexible`**: Similar to `.height`, except that PinLayout won't constrain the resulting height to match the reference height. The resulting height may be smaller of bigger depending on the view's sizeThatFits(..) method result.

	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#103](https://github.com/layoutBox/PinLayout/pull/103)

## [1.4.3](https://github.com/layoutBox/PinLayout/releases/tag/1.4.1)
Fix Carthage support

* Fix an issue that occurs with the latest Carthage version.

## [1.4.2](https://github.com/layoutBox/PinLayout/releases/tag/1.4.1)
#### Change
Add method that can pin multiples edges:

* `all()`: Pin all edges on its superview's corresponding edges (top, bottom, left, right). Similar to calling `view.top().bottom().left().right()`

* `horizontally()`: Pin the left and right edges on its superview's corresponding edges. Similar to calling `view.left().right()`.

* `vertically()`: Pin the **top and bottom edges** on its superview's corresponding edges. Similar to calling `view.top().bottom()`.
     
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#93](https://github.com/layoutBox/PinLayout/pull/93)
    

## [1.4.1](https://github.com/layoutBox/PinLayout/releases/tag/1.4.1)
#### Change
* Add new method `margin(_ directionalInsets: NSDirectionalEdgeInsets)`  

	Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#85](https://github.com/layoutBox/PinLayout/pull/85)
     
* Update all examples so they support iOS 11 and iPhoneX landscape mode. They use the new UIView.safeAreaInsets property.
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#85](https://github.com/layoutBox/PinLayout/pull/85)

## [1.4.0](https://github.com/layoutBox/PinLayout/releases/tag/1.4.0)
#### Change
* PinLayout now apply correctly margins when hCenter or vCenter have been set
	* hCenter: When the Horizontal Center is set, PinLayout now applies the left margin.
	* vCenter: When the Vertical Center is set, PinLayout now applies the top margin.

	**BREAKING CHANGE**: This may be a breaking change if you are using hCenter(..), vCenter(...), center(...), centerRight(...), centerLeft(...), or any other method using the center position while also using a margin.

	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#91](https://github.com/layoutBox/PinLayout/pull/91)


## [1.3.2](https://github.com/layoutBox/PinLayout/releases/tag/1.3.2)
#### Change
* Add **aspectRatio** methods:
	* **`aspectRatio(_ ratio: CGFloat)`**:  
Set the view aspect ratio. If a single dimension is set (either width or height), the aspect ratio will be used to compute the other dimension.  
		* AspectRatio is defined as the ratio between the width and the height (width / height). 
		* An aspect ratio of 2 means the width is twice the size of the height.
		* AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight) dimensions of an item.
Set all margins using an UIEdgeInsets.
This method is particularly useful to set all margins using iOS 11 UIView.safeAreaInsets
	* **`aspectRatio(of view: UIView)`**:  
	Set the view aspect ratio using another UIView's aspect ratio. 
     
     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.
     
     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     
 * **`aspectRatio()`**:  
	If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.
     
     For other types of views, this method as no impact. 
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#84](https://github.com/layoutBox/PinLayout/pull/84)
	
## [1.3.1](https://github.com/layoutBox/PinLayout/releases/tag/1.3.1)
#### Change
* Add new margin method `margin(_ insets: UIEdgeInsets)`  
Set all margins using an UIEdgeInsets.
This method is particularly useful to set all margins using iOS 11 UIView.safeAreaInsets
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#82](https://github.com/layoutBox/PinLayout/pull/82)
	
## [1.3.0](https://github.com/layoutBox/PinLayout/releases/tag/1.3.0)
Released on 2017-08-18. 

#### Change
* **Breaking change related to hCenter(CGFloat), hCenter(percent), vCenter(CGFloat), vCenter(percent)**:  
  * **`vCenter(_ value: CGFloat)`** and **`vCenter(_ percent: Percent)`**:  
The value specifies the distance vertically of the view's center **related to the superview's center** in pixels. Previously it was related to the **superview's top edge**.
  * **`hCenter(_ value: CGFloat)`** and **`hCenter(_ percent: Percent)`**:  
The value specifies the distance horizontally of the view's center **related to the superview's center** in pixels. Previously it was related to the **superview's left edge**.

Previously `hCenter(0)` wasn't equal to `hCenter()`, same thing for `vCenter(0)`. But this was an exception: `top(0)` == `top()`,` left(0)` == `left()`, `right(0)` == `right()`. Now thay all have the same logic.

## [1.2.4](https://github.com/layoutBox/PinLayout/releases/tag/1.2.4)
#### Change
* Add methods to pin hCenter and vCenter to any other view's edges (including the new hCenter and vCenter edges)
	*  **New methods**:
		* **`hCenter(to: edge)`**  
        Position horizontally the view's center directly on another view’s edge (left/hCenter/right)
		* **`vCenter(to: edge)`**  
        Position vertically the view's center directly on another view’s edge (top/vCenter/bottom).
	*  **New UIView's edges**:
		*  **`UIView.edge.hCenter`**
		*  **`UIView.edge.vCenter`**
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#80](https://github.com/layoutBox/PinLayout/pull/80) 
  
## [1.2.3](https://github.com/layoutBox/PinLayout/releases/tag/1.2.3)
#### Change
* Warnings now display more context information
  * The class name of the view being layouted.
  * The view's current frame 
  * The class name of all superviews
  * The view's Tag  

	Examples:
	
	* 👉 PinLayout Warning: width(50.0%) won't be applied, the view (UIView) must be added as a sub-view before being layouted using this method.  
(Layouted view info: Type: UIView, Frame: (10.0, 10.0, 20.0, 30.0), Tag: 0)
	
	* 👉 PinLayout Warning: width(-20.0) won't be applied, the width (-20.0) must be greater than or equal to zero.  
(Layouted view info: Type: ItemButton, Frame: (140.0, 100.0, 100.0, 60.0), Superviews: HomeView -> UIView, Tag: 0)
	
	* 👉 PinLayout Warning: topLeft(to: .topLeft, of: (UIView, Frame: (10.0, 10.0, 10.0, 10.0))) won't be applied, the reference view (UIView, Frame: (10.0, 10.0, 10.0, 10.0)) must be added as a sub-view before being used as a reference.  
(Layouted view info: Type: UIView, Frame: (140.0, 100.0, 100.0, 60.0), Superviews: UIView -> UIView, Tag: 0)

	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#75](https://github.com/layoutBox/PinLayout/pull/75) 

## [1.2.2](https://github.com/layoutBox/PinLayout/releases/tag/1.2.2)
#### Change
* Added a new method `fitSize()` that will replace the `sizeThatFit()` method. Its prior name was creating confusion with the already existingUIView.sizeToFit()` method.
* `sizeThatFit()` method has been marked as deprecated.

## [1.2.1](https://github.com/layoutBox/PinLayout/releases/tag/1.2.1)
#### Change
* Add Swift 4.0 support  

## [1.2.0](https://github.com/layoutBox/PinLayout/releases/tag/1.2.0)
Released on 2017-08-18. 

#### Change
* **Breaking change related to the following anchor's name**. The change makes these anchor's name more standard:  
  * **UIView.anchors.leftCenter** has been renamed UIView.anchors.centerLeft
  * **UIView.anchors.rightCenter** has been renamed UIView.anchors.centerRight

* **Add left to right (LTR) and right to left (RTL) language support**.  
Additions:
  * Pin.layoutDirection(_ direction: LayoutDirection)
  * start(), start(_ value: CGFloat), start(_ percent: Percent)
  * end(), end(_ value: CGFloat), end(_ percent: Percent)
  * UIView.edge.start
  * UIView.edge.end
  * UIView.anchor.topStart
  * UIView.anchor.topEnd
  * UIView.anchor.centerStart
  * UIView.anchor.centerEnd
  * UIView.anchor.bottomStart
  * UIView.anchor.bottomEnd
  * topStart(to anchor: Anchor), topStart()
  * topEnd(to anchor: Anchor), topEnd()
  * centerStart(to anchor: Anchor), centerStart()
  * centerEnd(to anchor: Anchor), centerEnd()
  * bottomStart(to anchor: Anchor), bottomStart()
  * bottomEnd(to anchor: Anchor), bottomEnd()
  * before(of: UIView), before(of: [UIView])
  * before(of: UIView, aligned: VerticalAlign), before(of: [UIView], aligned: VerticalAlign)
  * after(of: UIView), after(of: [UIView])
  * after(of: UIView, aligned: VerticalAlign), after(of: [UIView], aligned: VerticalAlign)
  * marginStart(_ value: CGFloat)
  * marginEnd(_ value: CGFloat)
  * HorizontalAlign.start
  * HorizontalAlign.end
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#56](https://github.com/layoutBox/PinLayout/pull/56) 



## [1.1.5](https://github.com/layoutBox/PinLayout/releases/tag/1.1.5)
Released on 2017-07-14. 

#### Change
* Fix missing UIKit import. The problem was occuring while using Swift Package Manager.
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#67](https://github.com/layoutBox/PinLayout/pull/67) 


## [1.1.4](https://github.com/layoutBox/PinLayout/releases/tag/1.1.4)
Released on 2017-07-09. 

#### Change
* Implementation of:
	* minWidth
	* maxWidth
	* minHeight
	* maxHeight
	* justify(:HorizontalAlign)
	* align(:VerticalAlign)
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#53](https://github.com/layoutBox/PinLayout/pull/53) 


## [1.1.1](https://github.com/layoutBox/PinLayout/releases/tag/1.1.1)
Released on 2017-06-27. 

#### Change
* Support **Xcode 9 Beta 2**
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#52](https://github.com/layoutBox/PinLayout/pull/52)
* Add a Form example
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#51](https://github.com/layoutBox/PinLayout/pull/51)  
	* This example demonstrates:  
		* Usage of filter method when using PinLayout's relative methods (above, below, left, right)
		* Adjusting a container's height to match all its children.
		* Animation of the appearance/disappearance of UIViews.

	
  
## [1.1.0](https://github.com/layoutBox/PinLayout/releases/tag/1.1.0)
Released on 2017-06-18. 

#### Change
* Update relative methods signatures when specifying multiple relative views.  
Update the minor version due to a small breaking change with methods above(of…), below(of…), left(of…) and right(of…). They now takes either a single UIView or an Array of UIViews.
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#48](https://github.com/layoutBox/PinLayout/pull/48)


## [1.0.15](https://github.com/layoutBox/PinLayout/releases/tag/1.0.15)
Released on 2017-06-12. 

#### Change
* Add **tvOS** support & set iOS target to 8.0 (instead of 10.2)
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#46](https://github.com/layoutBox/PinLayout/pull/46)


## [1.0.14](https://github.com/layoutBox/PinLayout/releases/tag/1.0.14)
Released on 2017-06-12. 

#### Change

* Implementation of **relative positioning using multiple relative views**
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#43](https://github.com/layoutBox/PinLayout/pull/43)
  * The following methods can now receives one or many relative views. Useful to position a view relative to many UIViews.  
	 * `above(of relativeViews: UIView...) `
	 * `above(of relativeViews: UIView..., aligned: HorizontalAlignment) `
	 * `below(of relativeViews: UIView...)`
	 * `below(of relativeViews: UIView..., aligned: HorizontalAlignment)`
	 * `left(of relativeViews: UIView...) `
	 * `left(of relativeViews: UIView..., aligned: VerticalAlignment)`
	 * `right(of relativeViews: UIView...) `
	 * `right(of relativeViews: UIView..., aligned: VerticalAlignment)`

## [1.0.11](https://github.com/layoutBox/PinLayout/releases/tag/1.0.11)
Released on 2017-06-08. 

#### Change

* Add **Swift Package Manager** support
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#38](https://github.com/layoutBox/PinLayout/pull/38
* **`size(…)` methods** now tries to apply the width and the height individually  
Previously the size specified was applied only if both the width and height wasn’t specified. Now PinLayout will apply them individually, so if the width has been specified yet, the size’s width will be applied, else a warning will be displayed that indicate that the width won’t be applied. Same thing for the height.
* Doesn’t display a warning anymore if the new specified width or height value is equal to the currently set value. This is coherent with other methods (top, left, hCenter, ….)
* Clean up `size(...)` methods source code
* Add PinLayout's performance documentation
* Add 52 more unit tests. Code coverage is now 95.38%.

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucdion) in Pull Request
  [#36](https://github.com/layoutBox/PinLayout/pull/36).


## [1.0.7](https://github.com/layoutBox/PinLayout/releases/tag/1.0.7)
Released on 2017-06-06. 

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucdion) in Pull Request
  [#36](https://github.com/layoutBox/PinLayout/pull/36).
