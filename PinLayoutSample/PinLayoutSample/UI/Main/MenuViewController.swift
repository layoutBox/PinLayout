// Copyright (c) 2017, Mirego
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
// - Neither the name of the Mirego nor the names of its contributors may
//   be used to endorse or promote products derived from this software without
//   specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

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
