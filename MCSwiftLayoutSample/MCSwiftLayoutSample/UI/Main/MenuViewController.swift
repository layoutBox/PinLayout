//
//  MenuViewController.swift
//  MCLayoutExample
//
//  Created by Luc Dion on 2016-09-03.
//  Copyright © 2016 Mirego. All rights reserved.
//
import UIKit

enum Page: Int {
    case viewExtensionsPositionning
    
    case relativePositions
    case multiRelativePositions
    
    case chainedLayout
    
    case bothEdgesSnapped
    case marginsAndPaddingLeftWidth
    case marginsAndPaddingLeftRight
    
    case validateConflicts
    
    case marginsAndInsets

    case scrollingPin
    
    case count
    
    var text: String {
        switch self {
        case .viewExtensionsPositionning: return "UIView's extensions positionning"
        case .relativePositions:          return "Test Relative"
        case .multiRelativePositions:     return "Test Multiple Relatives"
        case .chainedLayout:              return "Chained Layout"
        case .bothEdgesSnapped:           return "NOT USED YET"
        case .marginsAndPaddingLeftWidth: return "topLeft & width - Test margings and paddings"
        case .marginsAndPaddingLeftRight: return "topLeft & bottomRight - Test margings and paddings"
        case .validateConflicts:          return "Validate properties conflicts"
        case .marginsAndInsets:           return "Margins and Insets"
        case .scrollingPin:               return "Pin to UIScrollView"
        case .count:                      return "Unknown"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .viewExtensionsPositionning: return ViewExtensionsPositionningViewController()
        case .relativePositions:          return RelativeViewController()
        case .multiRelativePositions:     return MultiRelativeViewController()
        case .chainedLayout:              return ChainedLayoutViewController()
        case .bothEdgesSnapped:           return BothEdgesSnappedViewController()
        case .marginsAndPaddingLeftWidth: return MarginsAndPaddingsLeftWidthViewController()
        case .marginsAndPaddingLeftRight: return MarginsAndPaddingsLeftRightViewController()
        case .validateConflicts:          return ValidateConflictsViewController()
        case .marginsAndInsets:           return MarginsAndInsetsViewController()
        case .scrollingPin:               return PinScrollingViewController()
        case .count:                      return UIViewController()
        }
    }
}

class MenuViewController: UIViewController {
    fileprivate var mainView: MenuView {
        return self.view as! MenuView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
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
        didSelect(page: .bothEdgesSnapped)
    }
}

// MARK: MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    func didSelect(page: Page) {
        navigationController?.pushViewController(page.viewController, animated: true)
    }
}
