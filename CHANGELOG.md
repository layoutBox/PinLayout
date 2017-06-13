<p align="center">
	<img src="docs/pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout</h1>


# Change Log

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

<br>

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

<br>

## [1.0.7](https://github.com/mirego/PinLayout/releases/tag/1.0.7)
Released on 2017-06-06. 

### Fixes
- Fix an issue with pin.vCenter() and pin.hCenter()
  - Fixed by [Luc Dion](https://github.com/lucmirego) in Pull Request
  [#36](https://github.com/mirego/PinLayout/pull/36).
