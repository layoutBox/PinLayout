[![Build Status](https://travis-ci.org/mirego/PinLayout.svg?branch=master)](https://travis-ci.org/mirego/PinLayout)

# Swift PinLayout
"No constraints attached"

Simple layouting without using NSLayoutConstraint.


## PinLayout principles and philosophy

* Layout one view at a time. 
* Layout most views using a single line
* Stateless
	* The layout system doesn’t add any stored properties to UIViews. It simply compute the UIView.frame property, one view at a time.
	* Since it is stateless, it can be used with any other layout framework without conflicts. 
Each view can use the layout system that better suit it  (PinLayout, constraint, flexbox, grids, …)
A view can be layouted using PinLayout and later with another method.
	* REWORK THAT!!! Stateless also means that if a view reference other views, the view should be re-layouted in layoutSubViews()  layouted with PinLayout use other views as referenced view change (size/position) 

* No constraints
	* Constraints are very verbose and hard for a human brains to understand. Too much information.
	* PinLayout positions views as a designer would explain it (eg: “The TextField is below the Label, aligned left, and is its width match the other view’s width“). 
	* No priorities, simply layout views in the order that make sense. No priority required.

* Before applying the new sets of attributes, PinLayout always start with the view’s current frame. So it’s possible to set the view’s size during the initialization (ex: view.pin.width(100).height(200)), and later only position the view (ex: view.pin.top(10).left(20))

* Minimize as much as possible calculations and constants when layouting views.

* Methods matches as much as possible other layouting system, including CSS, flexbox, reactive Flexbox, …
	* margin, marginHorizontal, marginVertical, marginTop, marginLeft, marginBottom, marginRight
	* top, left, bottom, right, width, height  
	* As in CSS and flexbox, right and bottom coordinates are offset from container’s view right and bottom edges.

* Shorter possible commands to layout views, but keeping english phrasing almost valid.


## Installation
* Carthage

<br/>
# Documentation

## Layout using distances from superview’s edges
PinLayout can position a view’s edge relative to its superview edges.

**Methods**:

* `top(_ value: CGFloat)`  
The value specifies the distance in pixels between the top edge of the view and the top edge of its to superview
* `left(_ value: CGFloat)`  
The value specifies the distance in pixels between the left edge of the view and the left edge of its to superview
* `bottom(_ value: CGFloat)`  
The value specifies the distance in pixels between the bottom edge of the view and the bottom edge of its to superview.
* `right(_ value: CGFloat)`  
The value specifies the distance in pixels between the right edge of the view and the right edge of its to superview.
* `hCenter(_ value: CGFloat)`  
The value specifies the distance in pixels between the horizontal center of the view and the left edge of its to superview.
* `vCenter(_ value: CGFloat)`  
The value specifies the distance in pixels between the vertical center of the view and the top edge of its to superview.  


###### Usage Examples:

```javascript
    view.pin.top(20).left(20)
	view.pin.left(0).right(0)
	view.pin.left(12).vCenter(100)
```


###### Example:
>This example layout the view A to fit its superview frame with a margin of 10 pixels. It pins the top, left, bottom and right edges.

>![Flowers](Docs/01-example-distance-superview-edge.png)

>```javascript
	viewA.pin.top(10).left(10).bottom(10).right(10)
``` 
Another possible solution using other PinLayout's methods (more details later):

>```javascript
	view.pin.topLeft().bottomRight().margin(10)
```

<br/>
---
### Layout directly on superview’s edges 
PinLayout also have shorten version that pin a view’s edge **directly** on its superview corresponding edge.

**Methods**:

* `top()`  
Position the view top edge directly on its superview top edge. Similar to calling top(0)
* `left()`  
Position the view left edge directly on its superview top edge. Similar to calling left(0)
* `bottom()`  
Position the view bottom edge directly on its superview top edge. Similar to calling bottom(0)
* `right()`  
Position the view right edge directly on its superview top edge. Similar to calling right(0)

######Usage examples:
```javascript
	view.pin.top().left()
	view.pin.bottom().right()
```


###### Example:
>This example is similar to the previous example, but pin edges directly on superview’s edges. It layout the view A to fit its superview frame with a margin of 10 pixels..

>![](Docs/02-example-superview-edge.png)

>```javascript
	viewA.pin.top().left().bottom().right().margin(10)
``` 

<br/>
## Anchors

### PinLayout UIView’s anchors
PinLayout add anchors properties to UIViews. These properties are used to reference other view’s anchors.

**PinLayout UIView’s anchors**:

* `UIView.anchor.topLeft`
* `UIView.anchor.topCenter`
* `UIView.anchor.topRight`
* `UIView.anchor.leftCenter`
* `UIView.anchor.centers`
* `UIView.anchor.rightCenter`
* `UIView.anchor.bottomLeft`
* `UIView.anchor.bottomCenter`
* `UIView.anchor.bottomRight`

![](Docs/pinlayout-anchors.png)


<br/>
---
### Layout using anchors
PinLayout can use anchors to position view’s related to other views.

Following methods position the corresponding view anchor on another view’s anchor.

**Methods:**

* `topLeft(to anchor: Anchor)`
* `topCenter(to anchor: Anchor)`
* `topRight(to anchor: Anchor)`
* `leftCenter(to anchor: Anchor)`
* `center(to anchor: Anchor)`
* `rightCenter(to anchor: Anchor)`
* `bottomLeft(to anchor: Anchor)`
* `bottomCenter(to anchor: Anchor)`
* `bottomRight(to anchor: Anchor)`

NOTE: These methods can also pin a view’s anchor to another view that is not a direct sibling. It works with any views that have at some point the same ancestor. 

######Usage examples:
```javascript
	view.pin.topCenter(to: view1.anchor.bottomCenter)
    view.pin.topLeft(to: view1.anchor.topLeft).bottomRight(to: view1.anchor.center)
```

###### Example:
> Layout using an anchors. This example pins the view B topLeft anchor on the view A topRight anchor.

>![](Docs/example-anchors.png)

>```javascript
	viewB.pin.topLeft(to: viewA.anchor.topRight)
``` 

<br/>
###### Example:
> Layout using multiple anchors.
> 
It is also possible to combine two anchors to pin the position and the size of a view. The following example will position the view C between the view A and B with an horizontal margins of 10px.

>![](Docs/example-multiple-anchors.png)

>```javascript
	viewC.pin.topLeft(to: viewA.anchor.topRight)
	         .bottomRight(to: viewB.anchor.bottomLeft).marginHorizontal(10)
``` 

<br/>
---
### Layout using superview’s anchors
PinLayout also have shorten version that pin a view's anchor **directly** on its corresponding superview’s anchor.

Following methods position the corresponding view anchor on another view’s anchor.

**Methods:**

* `topLeft()`
* `topCenter()`
* `topRight()`
* `leftCenter()`
* `center()`
* `rightCenter()`
* `bottomLeft()`
* `bottomCenter()`
* `bottomRight()`

###### Example:
> For example .topRight() will pin the view’s topRight anchor on its superview’s topRight anchor..

>![](Docs/example-superview-anchors.png)

>```javascript
	viewA.pin.topRight()
``` 

>This is equivalent to:

>```javascript
	viewA.pin.topRight(to: superview.pin.topRight)
```

<br/>
## Edges

### PinLayout UIView’s edges
PinLayout add edges properties to UIViews. These properties are used to reference other view’s edges.

**PinLayout UIView’s edges**:

* `UIView.edge.top`
* `UIView.edge.left`
* `UIView.edge.bottom`
* `UIView.edge.right`

![](Docs/pinlayout-edges.png)

<br/>
---
### Layout using edges
PinLayout have methods to attach a UIView's edge (top, left, bottom or right edge) to another view’s edge.

**Methods:**

* `top(to edge: VerticalEdge)`
* `left(to: edge: HorizontalEdge)`
* `bottom(to edge: VerticalEdge)`
* `right(to: edge: HorizontalEdge)`

######Usage examples:
```javascript
	view.pin.left(to: view1.edge.right)
	view.pin.left(to: view1.edge.right).top(to: view2.edge.right)
```

<br/>
###### Example:
>Layout using an edge

>The following example layout the view B left edge on the view A right edge. It only change the view B left coordinate

>![](Docs/example-edges.png)

>```javascript
	viewB.pin.left(to: viewA.edge.right)
```


<br/>
# NOTE: Doc is not completed yet (work in progress...)

<br/>
## Relative positionning
### Layout using relative positioning
...

### Layout using relative positioning and alignment
...

<br/>
## Width, height and size
### Adjust view width, height and size
...


### sizeToFit()
...


## Margins

### PinLayout's margins
...

### pinEdges()
...

## Warnings
### PinLayout's warnings


<br/>
## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History
TODO

## Credits
TODO

## License