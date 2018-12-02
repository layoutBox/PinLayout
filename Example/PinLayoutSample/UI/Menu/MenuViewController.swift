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

import UIKit

enum PageType: Int {
    case intro
    case adjustToContainer
    case tableView
    case collectionView
    case animations
    case autoAdjustingSize
    case safeArea
    case relativePositions
    case between
    case form
    case wrapContent
    case tableViewWithReadable
    case introRTL
    case introObjC
    
    case count
    
    var title: String {
        switch self {
        case .intro:                  return "Introduction Example"
        case .adjustToContainer:      return "Adjust to Container Size"
        case .tableView:              return "UITableView with Variable Cell's Height"
        case .collectionView:         return "UICollectionView Example"
        case .animations:             return "Animation Example"
        case .autoAdjustingSize:      return "Auto Adjusting Size"
        case .safeArea:               return "SafeArea & readableMargins"
        case .relativePositions:      return "Relative Positioning"
        case .between:                return "Between Example"
        case .form:                   return "Form Example"
        case .wrapContent:            return "wrapContent Example"
        case .tableViewWithReadable:  return "UITableView using readableMargins"
        case .introRTL:               return "Right-to-left Language Support"
        case .introObjC:              return "Objective-C PinLayout Example"
        case .count:                  return ""
        }
    }

    var viewController: UIViewController {
        switch self {
        case .intro:
            return IntroViewController(pageType: self)
        case .adjustToContainer:
            return AdjustToContainerViewController(pageType: self)
        case .tableView:
            return TableViewExampleViewController(pageType: self)
        case .collectionView:
            return CollectionViewExampleViewController(pageType: self)
        case .safeArea:
            let tabbarController = UITabBarController()
            tabbarController.title = self.title
            tabbarController.setViewControllers([SafeAreaViewController(), SafeAreaAndMarginsViewController()], animated: false)
            return tabbarController
        case .animations:
            return AnimationsViewController(pageType: self)
        case .autoAdjustingSize:
            return AutoAdjustingSizeViewController(pageType: self)
        case .relativePositions:
            return RelativeViewController(pageType: self)
        case .between:
            return BetweenViewController(pageType: self)
        case .form:
            return FormViewController(pageType: self)
        case .wrapContent:
            return WrapContentViewController(pageType: self)
        case .tableViewWithReadable:
            return TableViewReadableContentViewController(pageType: self)
        case .introRTL:
            return IntroRTLViewController(pageType: self)
        case .introObjC:
            return IntroObjectiveCViewController()
        case .count:
            return UIViewController()
        }
    }
}

class MenuViewController: UIViewController {
    private var mainView: MenuView {
        return self.view as! MenuView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "PinLayout Examples"

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MenuView()
        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        didSelect(pageType: .intro)
    }
}

// MARK: MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    func didSelect(pageType: PageType) {
        navigationController?.pushViewController(pageType.viewController, animated: true)
    }
}
