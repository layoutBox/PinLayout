<p align="center">
	<img src="docs/pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout</h1>


# Change Log


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
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#53](https://github.com/mirego/PinLayout/pull/53) 


## [1.1.1](https://github.com/mirego/PinLayout/releases/tag/1.1.1)
Released on 2017-06-27. 

#### Change
* Support **Xcode 9 Beta 2**
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#52](https://github.com/mirego/PinLayout/pull/52)
* Add a Form example
	* Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#51](https://github.com/mirego/PinLayout/pull/51)  
	* This example demonstrates:  
		* Usage of filter method when using PinLayout's relative methods (above, below, left, right)
		* Adjusting a container's height to match all its children.
		* Animation of the appearance/disappearance of UIViews.

	
  
## [1.1.0](https://github.com/mirego/PinLayout/releases/tag/1.1.0)
Released on 2017-06-18. 

#### Change
* Update relative methods signatures when specifying multiple relative views.  
Update the minor version due to a small breaking change with methods above(of…), below(of…), left(of…) and right(of…). They now takes either a single UIView or an Array of UIViews.
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#48](https://github.com/mirego/PinLayout/pull/48)


## [1.0.15](https://github.com/mirego/PinLayout/releases/tag/1.0.15)
Released on 2017-06-12. 

#### Change
* Add **tvOS** support & set iOS target to 8.0 (instead of 10.2)
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#46](https://github.com/mirego/PinLayout/pull/46)


## [1.0.14](https://github.com/mirego/PinLayout/releases/tag/1.0.14)
Released on 2017-06-12. 

#### Change

* Implementation of **relative positioning using multiple relative views**
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#43](https://github.com/mirego/PinLayout/pull/43)
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
  * Added by [Luc Dion](https://github.com/lucmirego) in Pull Request [#38](https://github.com/mirego/PinLayout/pull/38
* **`size(…)` methods** now tries to apply the width and the height individually  
Previously the size specified was applied only if both the width and height wasn’t specified. Now PinLayout will apply them individually, so if the width has been specified yet, the size’s width will be applied, else a warning will be displayed that indicate that the width won’t be applied. Same thing for the height.
* Doesn’t display a warning anymore if the new specified width or height value is equal to the currently set value. This is coherent with other methods (top, left, hCenter, ….)
* Clean up `size(...)` methods source code
* Add PinLayout's performance documentation
* Add 52 more unit tests. Code coverage is now 95.38%.

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucmirego) in Pull Request
  [#36](https://github.com/mirego/PinLayout/pull/36).


## [1.0.7](https://github.com/mirego/PinLayout/releases/tag/1.0.7)
Released on 2017-06-06. 

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucmirego) in Pull Request
  [#36](https://github.com/mirego/PinLayout/pull/36).
