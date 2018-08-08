<p align="center">
	<img src="pinlayout-logo-small.png" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">Animations using PinLayout</h1>

#### PinLayout is stateless
It is important that PinLayout is stateless, i.e. PinLayout always start from the view's current position and size (frame) when layouting a view. You don't need to reset anything to animate a view using PinLayout.

This also means that you can modify only the property you want to animate, for example the following code will only animate the view's width:
 
```
   UIView.animate(withDuration: 0.3) { 
      view.pin.width(30)
   }
``` 

#### Layout strategies
Multiple strategies can be used to animate layout using PinLayout. The choice is  a question of preferences and the kind of animations you want to achieve.

Some possible possible strategies will be shown below using a really simple example. The example 


All examples below animate the appearance of an UIImageView.

**1- Basic: Using UIView.setNeedsLayout + UIView.layoutIfNeeded.**

```
var isImageVisible = false

func layoutSubviews() {
   super.layoutSubviews()

   let imageLeftPosition = isImageVisible ? 0 : -imageView.frame.width
   imageView.pin.left(imageLeftPosition).vCenter() 
   ...
}

func didTapTogglemage() {
   UIView.animate(withDuration: 0.2) { 
         self.isImageVisible = !self.isImageVisible
         self.setNeedsLayout()
         self.layoutIfNeeded()
    }
}
```

**2- Using a layout method.**

```
var isImageVisible = false

func layoutSubviews() {
   super.layoutSubviews()
   layoutImageView()
   ...
}

func layoutImageView() {
   let imageLeftPosition = isImageVisible ? 0 : -imageView.frame.width
   imageView.pin.left(imageLeftPosition).vCenter() 
}

func didTapTogglemage() {
   UIView.animate(withDuration: 0.2) { 
         self.isImageVisible = !self.isImageVisible
         self.layoutImageView()
    }
}
```

**3- Using a state and having multiple separates layout methods.**

```
enum State {
   case initial
   case imageVisible
}
var state = State.initial

func layoutSubviews() {
   super.layoutSubviews()

   switch state {
   case .initial: layoutInitialState()
   case .imageVisible: layoutImageVisibleState()
   }
}

func layoutInitialState() {
   imageView.pin.left(-imageView.frame.width).vCenter() 
   ...
}

func layoutImageVisibleState() {
   imageView.pin.left(0).vCenter() 
   ...
}
```


<a href="https://github.com/layoutBox/PinLayout/blob/master/Example/PinLayoutSample/UI/Examples/Animations/AnimationsView.swift"><img src="images/example-animations.gif" width=120/></a> 
