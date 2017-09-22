<p align="center">
	<img src="docs/pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout</h1>


# Change Log
## [1.3.0](https://github.com/mirego/PinLayout/releases/tag/1.3.0)
Released on 2017-08-18. 

#### Change
* **Breaking change related to hCenter(CGFloat), hCenter(percent), vCenter(CGFloat), vCenter(percent)**:  
  * **`vCenter(_ value: CGFloat)`** and **`vCenter(_ percent: Percent)`**:  
The value specifies the distance vertically of the view's center **related to the superview's center** in pixels. Previously it was related to the **superview's top edge**.
  * **`hCenter(_ value: CGFloat)`** and **`hCenter(_ percent: Percent)`**:  
The value specifies the distance horizontally of the view's center **related to the superview's center** in pixels. Previously it was related to the **superview's left edge**.

Previously `hCenter(0)` wasn't equal to `hCenter()`, same thing for `vCenter(0)`. But this was an exception: `top(0)` == `top()`,` left(0)` == `left()`, `right(0)` == `right()`. Now thay all have the same logic.

## [1.2.4](https://github.com/mirego/PinLayout/releases/tag/1.2.4)
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
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#80](https://github.com/mirego/PinLayout/pull/80) 
  
## [1.2.3](https://github.com/mirego/PinLayout/releases/tag/1.2.3)
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

	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#75](https://github.com/mirego/PinLayout/pull/75) 

## [1.2.2](https://github.com/mirego/PinLayout/releases/tag/1.2.2)
#### Change
* Added a new method `fitSize()` that will replace the `sizeThatFit()` method. Its prior name was creating confusion with the already existingUIView.sizeToFit()` method.
* `sizeThatFit()` method has been marked as deprecated.

## [1.2.1](https://github.com/mirego/PinLayout/releases/tag/1.2.1)
#### Change
* Add Swift 4.0 support  

## [1.2.0](https://github.com/mirego/PinLayout/releases/tag/1.2.0)
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
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#56](https://github.com/mirego/PinLayout/pull/56) 



## [1.1.5](https://github.com/mirego/PinLayout/releases/tag/1.1.5)
Released on 2017-07-14. 

#### Change
* Fix missing UIKit import. The problem was occuring while using Swift Package Manager.
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#67](https://github.com/mirego/PinLayout/pull/67) 


## [1.1.4](https://github.com/mirego/PinLayout/releases/tag/1.1.4)
Released on 2017-07-09. 

#### Change
* Implementation of:
	* minWidth
	* maxWidth
	* minHeight
	* maxHeight
	* justify(:HorizontalAlign)
	* align(:VerticalAlign)
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#53](https://github.com/mirego/PinLayout/pull/53) 


## [1.1.1](https://github.com/mirego/PinLayout/releases/tag/1.1.1)
Released on 2017-06-27. 

#### Change
* Support **Xcode 9 Beta 2**
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#52](https://github.com/mirego/PinLayout/pull/52)
* Add a Form example
	* Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#51](https://github.com/mirego/PinLayout/pull/51)  
	* This example demonstrates:  
		* Usage of filter method when using PinLayout's relative methods (above, below, left, right)
		* Adjusting a container's height to match all its children.
		* Animation of the appearance/disappearance of UIViews.

	
  
## [1.1.0](https://github.com/mirego/PinLayout/releases/tag/1.1.0)
Released on 2017-06-18. 

#### Change
* Update relative methods signatures when specifying multiple relative views.  
Update the minor version due to a small breaking change with methods above(of…), below(of…), left(of…) and right(of…). They now takes either a single UIView or an Array of UIViews.
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#48](https://github.com/mirego/PinLayout/pull/48)


## [1.0.15](https://github.com/mirego/PinLayout/releases/tag/1.0.15)
Released on 2017-06-12. 

#### Change
* Add **tvOS** support & set iOS target to 8.0 (instead of 10.2)
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#46](https://github.com/mirego/PinLayout/pull/46)


## [1.0.14](https://github.com/mirego/PinLayout/releases/tag/1.0.14)
Released on 2017-06-12. 

#### Change

* Implementation of **relative positioning using multiple relative views**
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#43](https://github.com/mirego/PinLayout/pull/43)
  * The following methods can now receives one or many relative views. Useful to position a view relative to many UIViews.  
	 * `above(of relativeViews: UIView...) `
	 * `above(of relativeViews: UIView..., aligned: HorizontalAlignment) `
	 * `below(of relativeViews: UIView...)`
	 * `below(of relativeViews: UIView..., aligned: HorizontalAlignment)`
	 * `left(of relativeViews: UIView...) `
	 * `left(of relativeViews: UIView..., aligned: VerticalAlignment)`
	 * `right(of relativeViews: UIView...) `
	 * `right(of relativeViews: UIView..., aligned: VerticalAlignment)`

## [1.0.11](https://github.com/mirego/PinLayout/releases/tag/1.0.11)
Released on 2017-06-08. 

#### Change

* Add **Swift Package Manager** support
  * Added by [Luc Dion](https://github.com/lucdion) in Pull Request [#38](https://github.com/mirego/PinLayout/pull/38
* **`size(…)` methods** now tries to apply the width and the height individually  
Previously the size specified was applied only if both the width and height wasn’t specified. Now PinLayout will apply them individually, so if the width has been specified yet, the size’s width will be applied, else a warning will be displayed that indicate that the width won’t be applied. Same thing for the height.
* Doesn’t display a warning anymore if the new specified width or height value is equal to the currently set value. This is coherent with other methods (top, left, hCenter, ….)
* Clean up `size(...)` methods source code
* Add PinLayout's performance documentation
* Add 52 more unit tests. Code coverage is now 95.38%.

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucdion) in Pull Request
  [#36](https://github.com/mirego/PinLayout/pull/36).


## [1.0.7](https://github.com/mirego/PinLayout/releases/tag/1.0.7)
Released on 2017-06-06. 

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucdion) in Pull Request
  [#36](https://github.com/mirego/PinLayout/pull/36).
