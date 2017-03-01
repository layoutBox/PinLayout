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
    
    case marginsAndPaddingLeftWidth
    case marginsAndPaddingLeftRight
    
    case validateConflicts
    case count
    
    var text: String {
        switch self {
        case .viewExtensionsPositionning: return "UIView's extensions positionning"
        case .relativePositions:          return "Test Relative"
        case .multiRelativePositions:     return "Test Multiple Relatives"
        case .chainedLayout:              return "Chained Layout"
        case .marginsAndPaddingLeftWidth: return "Test margings and paddings - Left+Width"
        case .marginsAndPaddingLeftRight: return "Test margings and paddings - Left+Right"
        case .validateConflicts:          return "Validate properties conflicts"
        case .count:                             return "Unknown"
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
}

// MARK: MenuViewDelegate
extension MenuViewController: MenuViewDelegate {
    func didSelect(page: Page) {
        var controller: UIViewController?
        
        switch page {
        case .viewExtensionsPositionning:
            controller = ViewExtensionsPositionningViewController()
        case .relativePositions:
            controller = RelativeViewController()
        case .multiRelativePositions:
            controller = MultiRelativeViewController()
        case .chainedLayout:
            controller = ChainedLayoutViewController()
        case .marginsAndPaddingLeftWidth:
            controller = MarginsAndPaddingsLeftWidthViewController()
        case .marginsAndPaddingLeftRight:
            controller = MarginsAndPaddingsLeftRightViewController()
        case .validateConflicts:
            controller = ValidateConflictsViewController()
        default:
            assert(false)
            break
        }
        
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
