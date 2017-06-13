<p align="center">
	<img src="pinlayout-logo-small.png" alt="PinLayout Performance" width=100/>
</p>

<h1 align="center" style="color: #376C9D; font-family: Arial Black, Gadget, sans-serif; font-size: 1.5em">PinLayout Benchmark</h1>

## Methodology

##### LayoutKit Benchmark
PinLayout's performance has been tested using a fork of [LayoutKit](https://github.com/mirego/LayoutKit). LayoutKit include an example app with a really nice and simple benchmark. It is used to compare LayoutKit with Auto layout, UIStackViews and manual layouting. 

The benchmark has been modified to also include [PinLayout](https://github.com/mirego/LayoutKit/blob/master/LayoutKitSampleApp/Benchmarks/FeedItemPinLayoutView.swift). Remark in the implemantation that PinLayout's layout code is concise, clean and doesn't contain any computation [compared to Manual Layouting source code](#source_code_compare).


The benchmark include tests for the following layout systems:

* Auto layout
* Auto layout using UIStackViews
* LayoutKit
* Manual layout (i.e. set UIView's frame directly)
* PinLayout

Anyone who would like to integrate any other layout frameworks to this GitHub repository is welcome.

##### Benchmark details
The LayoutKit benchmark layout UICollectionView and UITableView cells in multiple pass, each pass contains more cells than the previous one. The **X axis** in following charts indicates the **number of cells** contained for each pass. The **Y axis** indicates the **number of seconds** to render all cells from one pass.

Here are the rendering results to compare visual results:
 
* [Auto layout rendering result](Benchmark/Benchmark-Autolayout.png)
* [PinLayout rendering result](Benchmark/Benchmark-PinLayout.png)
* [LayoutKit rendering result](Benchmark/Benchmark-LayoutKit.png)

## Results

As you can see in the following chart, PinLayout's performance is as fast as manual layouting, and up to **12x faster than auto layout**, and **16x faster than UIStackViews**. [LayoutKit](https://github.com/linkedin/LayoutKit) is also really fast, slightly slower than PinLayout and manual layouting.

These results also means that PinLayout is by far faster than any layout frameworks that is built over auto layout (SnapKit, Stevia, PureLayout, ...). 

It takes almost half a second (0.468 ms) to render 100 UICollectionView's cells using UIStackViews, and 1/3 of second (0.344) using auto layout on a iPhone 6S device.

<br>

<p align="center">iPhone 6S - iOS 10.3.2</p>
<p align="center">
  <a href=""><img src="Benchmark/Chart-iPhone6S.png" alt="PinLayout Performance"/></a>
<p align="center" style="font-size:10px;">X axis in the number cells in a UICollectionView, and Y axis is the time in seconds to layout all cells</p>
</p> 

You can have a look at the [spreadsheet containing all the data](Benchmark/Benchmark-iPhone6S.xlsx)

<br>

## PinLayout Benchmark Source code <a name="source_code_compare"></a>

PinLayout's layout code is concise, clean and doesn't contain any computation compared to Manual Layouting source code.


#### Manual layouting benchmark source code

``` 
override func layoutSubviews() {
    super.layoutSubviews()
    
    optionsLabel.frame = CGRect(x: bounds.width-optionsLabel.frame.width, y: 0, 
                                width: optionsLabel.frame.width, height: optionsLabel.frame.height)
    actionLabel.frame = CGRect(x: 0, y: 0, width: bounds.width-optionsLabel.frame.width, height: 0)
    actionLabel.sizeToFit()

    posterImageView.frame = CGRect(x: 0, y: actionLabel.frame.bottom, 
                                   width: posterImageView.frame.width, height: 0)
    posterImageView.sizeToFit()

    let contentInsets = UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 3)
    let posterLabelWidth = bounds.width-posterImageView.frame.width - contentInsets.left - 
                           contentInsets.right
    posterNameLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, 
                                   y: posterImageView.frame.origin.y + contentInsets.top, 
                                   width: posterLabelWidth, height: 0)
    posterNameLabel.sizeToFit()

    let spacing: CGFloat = 1
    posterHeadlineLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, 
                                       y: posterNameLabel.frame.bottom + spacing, 
                                       width: posterLabelWidth, height: 0)
    posterHeadlineLabel.sizeToFit()

    posterTimeLabel.frame = CGRect(x: posterImageView.frame.right + contentInsets.left, 
                                   y: posterHeadlineLabel.frame.bottom + spacing, width: posterLabelWidth, 
                                   height: 0)
    posterTimeLabel.sizeToFit()

    posterCommentLabel.frame = CGRect(x: 0, y: max(posterImageView.frame.bottom, 
                                                   posterTimeLabel.frame.bottom + 
                                                   contentInsets.bottom), 
                                      width: frame.width, height: 0)
    posterCommentLabel.sizeToFit()

    contentImageView.frame = CGRect(x: frame.width/2 - contentImageView.frame.width/2, 
                                    y: posterCommentLabel.frame.bottom, width: frame.width, height: 0)
    contentImageView.sizeToFit()

    contentTitleLabel.frame = CGRect(x: 0, y: contentImageView.frame.bottom, width: frame.width, height: 0)
    contentTitleLabel.sizeToFit()

    contentDomainLabel.frame = CGRect(x: 0, y: contentTitleLabel.frame.bottom, width: frame.width, height: 0)
    contentDomainLabel.sizeToFit()

    likeLabel.frame = CGRect(x: 0, y: contentDomainLabel.frame.bottom, width: 0, height: 0)
    likeLabel.sizeToFit()

    commentLabel.sizeToFit()
    commentLabel.frame = CGRect(x: frame.width/2-commentLabel.frame.width/2, 
                                y: contentDomainLabel.frame.bottom, 
                                width: commentLabel.frame.width, height: commentLabel.frame.height)

    shareLabel.sizeToFit()
    shareLabel.frame = CGRect(x: frame.width-shareLabel.frame.width, y: contentDomainLabel.frame.bottom, 
                              width: shareLabel.frame.width, height: shareLabel.frame.height)

    actorImageView.frame = CGRect(x: 0, y: likeLabel.frame.bottom, width: 0, height: 0)
    actorImageView.sizeToFit()

    actorCommentLabel.frame = CGRect(x: actorImageView.frame.right, y: likeLabel.frame.bottom, 
                                     width: frame.width-actorImageView.frame.width, height: 0)
    actorCommentLabel.sizeToFit()
}
```

### PinLayout benchmark source code

```
override func layoutSubviews() {
    super.layoutSubviews()
    
    let hMargin: CGFloat = 8
    let vMargin: CGFloat = 2
    
    optionsLabel.pin.topRight().margin(hMargin)
    actionLabel.pin.topLeft().margin(hMargin)
    
    posterImageView.pin.below(of: actionLabel, aligned: .left).marginTop(10)
    posterNameLabel.pin.right(of: posterImageView, aligned: .top).margin(-6, 6).right(hMargin).sizeToFit()
    posterHeadlineLabel.pin.below(of: posterNameLabel, aligned: .left).right(hMargin).marginTop(1).sizeToFit()
    posterTimeLabel.pin.below(of: posterHeadlineLabel, aligned: .left).right(hMargin).marginTop(1).sizeToFit()
    
    posterCommentLabel.pin.below(of: posterTimeLabel).left(hMargin).right().right(hMargin)
        .marginTop(vMargin).sizeToFit()
    
    contentImageView.pin.below(of: posterCommentLabel).hCenter().width(100%).sizeToFit()
    contentTitleLabel.pin.below(of: contentImageView).left().right().marginHorizontal(hMargin).sizeToFit()
    contentDomainLabel.pin.below(of: contentTitleLabel, aligned: .left).right().marginRight(hMargin)
        .sizeToFit()
    
    likeLabel.pin.below(of: contentDomainLabel, aligned: .left).marginTop(vMargin)
    commentLabel.pin.top(to: likeLabel.edge.top).hCenter(50%)
    shareLabel.pin.top(to: likeLabel.edge.top).right().marginRight(hMargin)
    
    actorImageView.pin.below(of: likeLabel, aligned: .left).marginTop(vMargin)
    actorCommentLabel.pin.right(of: actorImageView, aligned: .center).marginLeft(4)
}
```

