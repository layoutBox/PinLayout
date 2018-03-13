//
//  UIViewSafeAreaTests.swift
//  TaylorTests
//
//  Created by Antoine Lamy on 2017-12-28.
//  Copyright © 2017 Mirego. All rights reserved.
//

import XCTest
import PinLayout

class UIViewSafeAreaTests: XCTestCase {
    private var viewController: TestViewController!
    private var navigationController: UINavigationController!
    private var window: UIWindow!

    override class func setUp() {
        super.setUp()
    }
    
    override func setUp() {
        super.setUp()
        viewController = TestViewController()
        navigationController = UINavigationController(rootViewController: viewController)
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
        navigationController = nil
        window = nil
    }

    private func setupWindow(with viewController: UIViewController) {
        window = UIWindow()
        window.rootViewController = viewController
        window.addSubview(viewController.view)

        // Testing UIViewController's layout methods is kind of bad
        // but needed in our case so we need to wait some time
        RunLoop.current.run(until: Date().addingTimeInterval(1))
    }

    func testOpaqueNavigationBar() {
        viewController.mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
            offsetView.pin.top(10).width(100).height(100)
        }

        navigationController.navigationBar.barStyle = .blackOpaque
        navigationController.navigationBar.isTranslucent = false
        setupWindow(with: navigationController)

        let expectedSafeAreaInsets = UIEdgeInsets.zero
        let expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero

        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
            XCTAssertEqual(viewController.mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
        }

        XCTAssertEqual(viewController.mainView.pin.safeArea, expectedSafeAreaInsets)
        XCTAssertEqual(viewController.mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
        XCTAssertFalse(viewController.mainView.safeAreaInsetsDidChangeCalled)

        let screenSize = viewController.view.frame.size
        XCTAssertEqual(viewController.mainView.frame, CGRect(x: 0, y: 44, width: screenSize.width, height: screenSize.height))
        XCTAssertEqual(viewController.mainView.offsetView.frame, CGRect(x: 0, y: 10, width: 100, height: 100))
    }

    func testTranslucentNavigationBar_OffsetViewInsideSafeArea() {
        viewController.mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
            offsetView.pin.all().margin(parent.pin.safeArea)
        }

        let expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        let expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero

        navigationController.navigationBar.barStyle = .blackTranslucent
        setupWindow(with: navigationController)

        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
            XCTAssertEqual(viewController.mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
        }
        XCTAssertEqual(viewController.mainView.pin.safeArea, expectedSafeAreaInsets)
        XCTAssertEqual(viewController.mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
        XCTAssertTrue(viewController.mainView.safeAreaInsetsDidChangeCalled)

        let screenSize = viewController.view.frame.size
        XCTAssertEqual(viewController.mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        XCTAssertEqual(viewController.mainView.offsetView.frame, CGRect(x: 0, y: 44, width: screenSize.width, height: screenSize.height - 44))
    }

    func testTranslucentNavigationBar_OffsetViewTouchTopSafeArea() {
        viewController.mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
            offsetView.pin.top(10).width(100).height(100)
        }

        let expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        let expectedOffsetViewSafeAreaInsets = UIEdgeInsets(top: 34, left: 0, bottom: 0, right: 0)

        navigationController.navigationBar.barStyle = .blackTranslucent
        setupWindow(with: navigationController)

        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
            XCTAssertEqual(viewController.mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
        }
        XCTAssertEqual(viewController.mainView.pin.safeArea, expectedSafeAreaInsets)
        XCTAssertEqual(viewController.mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)

        let screenSize = viewController.view.frame.size
        XCTAssertEqual(viewController.mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        XCTAssertEqual(viewController.mainView.offsetView.frame, CGRect(x: 0, y: 10, width: 100, height: 100))
        XCTAssertTrue(viewController.mainView.safeAreaInsetsDidChangeCalled)
    }

    func testTranslucentNavigationBar_WithAdditionalSafeAreaInsets_OffsetViewInsideSafeArea() {
        viewController.mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
            offsetView.pin.all().margin(parent.pin.safeArea)
        }

        navigationController.navigationBar.barStyle = .blackTranslucent
        setupWindow(with: navigationController)

        let expectedSafeAreaInsets: UIEdgeInsets
        let expectedOffsetViewSafeAreaInsets: UIEdgeInsets
        let expectedOffsetViewFrame: CGRect
        let screenSize = viewController.view.frame.size

        if #available(iOS 11.0, tvOS 11.0, *) {
            viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 0)
            expectedSafeAreaInsets = UIEdgeInsets(top: 54, left: 10, bottom: 30, right: 0)
            expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero
            expectedOffsetViewFrame = CGRect(x: 0, y: 44, width: screenSize.width,
                                             height: screenSize.height - 44)
        } else {
            expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
            expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero
            expectedOffsetViewFrame = CGRect(x: 0, y: 44, width: screenSize.width,
                                             height: screenSize.height - expectedSafeAreaInsets.top)
        }

        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
            XCTAssertEqual(viewController.mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
        }
        XCTAssertEqual(viewController.mainView.pin.safeArea, expectedSafeAreaInsets)
        XCTAssertEqual(viewController.mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
        XCTAssertTrue(viewController.mainView.safeAreaInsetsDidChangeCalled)

        XCTAssertEqual(viewController.mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        XCTAssertEqual(viewController.mainView.offsetView.frame, expectedOffsetViewFrame)
    }

    func testTranslucentNavigationBar_WithAdditionalSafeAreaInsets_OffsetViewTouchTopSafeArea() {
        viewController.mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
            offsetView.pin.top(10).width(100).height(100)
        }

        let expectedSafeAreaInsets: UIEdgeInsets
        let expectedOffsetViewSafeAreaInsets: UIEdgeInsets
        if #available(iOS 11.0, tvOS 11.0, *) {
            viewController.additionalSafeAreaInsets = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 0)
            expectedSafeAreaInsets = UIEdgeInsets(top: 54, left: 10, bottom: 30, right: 0)
            expectedOffsetViewSafeAreaInsets = UIEdgeInsets(top: 44, left: 10, bottom: 0, right: 0)
        } else {
            expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
            expectedOffsetViewSafeAreaInsets = UIEdgeInsets(top: 34, left: 0, bottom: 0, right: 0)
        }
        navigationController.navigationBar.barStyle = .blackTranslucent
        setupWindow(with: navigationController)

        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
            XCTAssertEqual(viewController.mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
        }
        XCTAssertEqual(viewController.mainView.pin.safeArea, expectedSafeAreaInsets)
        XCTAssertEqual(viewController.mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
        XCTAssertTrue(viewController.mainView.safeAreaInsetsDidChangeCalled)
    }
}

fileprivate class TestViewController: UIViewController {
    var mainView: TestView { return self.view as! TestView }
    override func loadView() {
        self.view = TestView()
    }
}

fileprivate class TestView: UIView {
    let offsetView = UIView()
    var safeAreaInsetsDidChangeCalled: Bool = false
    var layoutOffsetViewClosure: ((_ offsetView: UIView, _ parent: UIView) -> Void)?

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.red

        offsetView.backgroundColor = UIColor.green
        addSubview(offsetView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        assert(layoutOffsetViewClosure != nil)
        layoutOffsetViewClosure?(offsetView, self)
    }

    override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            super.safeAreaInsetsDidChange()
        }
        
        safeAreaInsetsDidChangeCalled = true
    }
}
