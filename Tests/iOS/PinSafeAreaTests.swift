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

import XCTest
import PinLayout
import Quick
import Nimble

class PinSafeAreaSpec: QuickSpec {
    override func spec() {
        var viewController: TestViewController!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            Pin.safeAreaInsetsDidChangeMode = .always
            viewController = TestViewController()
            navigationController = UINavigationController(rootViewController: viewController)
        }

        afterEach {
            Pin.safeAreaInsetsDidChangeMode = .disable
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("using opaque NavigationBar") {
            it("testOpaqueNavigationBar") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
                    offsetView.pin.top(10).width(100).height(100)
                }

                navigationController.navigationBar.isTranslucent = false
                setupWindow(with: navigationController)

                let expectedSafeAreaInsets = UIEdgeInsets.zero
                let expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero

                if #available(iOS 11.0, tvOS 11.0, *) {
                    expect(viewController.view.safeAreaInsets).to(equal(expectedSafeAreaInsets))
                    expect(mainView.offsetView.safeAreaInsets).to(equal(expectedOffsetViewSafeAreaInsets))
                }

                expect(mainView.pin.safeArea).to(equal(expectedSafeAreaInsets))
                expect(mainView.offsetView.pin.safeArea).to(equal(expectedOffsetViewSafeAreaInsets))
                expect(mainView.safeAreaInsetsDidChangeCalledCount).to(equal(0))

                let screenSize = mainView.frame.size
                expect(mainView.frame).to(equal(CGRect(x: 0, y: 44, width: screenSize.width, height: screenSize.height)))
                expect(mainView.offsetView.frame).to(equal(CGRect(x: 0, y: 10, width: 100, height: 100)))
            }
        }

        describe("using translucent NavigationBar") {
            it("default") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
                    offsetView.pin.all().margin(parent.pin.safeArea)
                }

                let expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
                let expectedOffsetViewSafeAreaInsets = UIEdgeInsets.zero

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                if #available(iOS 11.0, tvOS 11.0, *) {
                    XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
                    XCTAssertEqual(mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
                }
                XCTAssertEqual(mainView.pin.safeArea, expectedSafeAreaInsets)
                XCTAssertEqual(mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0

                let screenSize = mainView.frame.size
                XCTAssertEqual(mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
                XCTAssertEqual(mainView.offsetView.frame, CGRect(x: 0, y: 44, width: screenSize.width, height: screenSize.height - 44))
            }

            it("with OffsetView") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
                    offsetView.pin.top(10).width(100).height(100)
                }

                let expectedSafeAreaInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
                let expectedOffsetViewSafeAreaInsets = UIEdgeInsets(top: 34, left: 0, bottom: 0, right: 0)

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                if #available(iOS 11.0, tvOS 11.0, *) {
                    XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
                    XCTAssertEqual(mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
                }
                XCTAssertEqual(mainView.pin.safeArea, expectedSafeAreaInsets)
                XCTAssertEqual(mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)

                let screenSize = mainView.frame.size
                XCTAssertEqual(mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
                XCTAssertEqual(mainView.offsetView.frame, CGRect(x: 0, y: 10, width: 100, height: 100))
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
            }

            it("with OffsetView and AdditionalSafeAreaInsets") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
                    offsetView.pin.all().margin(parent.pin.safeArea)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                let expectedSafeAreaInsets: UIEdgeInsets
                let expectedOffsetViewSafeAreaInsets: UIEdgeInsets
                let expectedOffsetViewFrame: CGRect
                let screenSize = mainView.frame.size

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
                    XCTAssertEqual(mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
                }
                XCTAssertEqual(mainView.pin.safeArea, expectedSafeAreaInsets)
                XCTAssertEqual(mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0

                XCTAssertEqual(mainView.frame, CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
                XCTAssertEqual(mainView.offsetView.frame, expectedOffsetViewFrame)
            }

            it("with OffsetView and AdditionalSafeAreaInsets 2") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ offsetView: UIView, _ parent: UIView) in
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

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                if #available(iOS 11.0, tvOS 11.0, *) {
                    XCTAssertEqual(viewController.view.safeAreaInsets, expectedSafeAreaInsets)
                    XCTAssertEqual(mainView.offsetView.safeAreaInsets, expectedOffsetViewSafeAreaInsets)
                }
                XCTAssertEqual(mainView.pin.safeArea, expectedSafeAreaInsets)
                XCTAssertEqual(mainView.offsetView.pin.safeArea, expectedOffsetViewSafeAreaInsets)
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
            }
        }
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
    var safeAreaInsetsDidChangeCalledCount: Int = 0
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
        safeAreaInsetsDidChangeCalledCount += 1
    }
}

class PinSafeAreaMoreTestsSpec: QuickSpec {
    override func spec() {
        var viewController: TestViewController2!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            Pin.safeAreaInsetsDidChangeMode = .always
            viewController = TestViewController2()
            navigationController = UINavigationController(rootViewController: viewController)
        }

        afterEach {
            Pin.safeAreaInsetsDidChangeMode = .disable
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("navigationbar + subview") {
            it("transluscent navigationbar 1") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).left(10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                expect(mainView.subView.frame).to(equal(CGRect(x: 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }

            it("transluscent navigationbar 2") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).left(-10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                expect(mainView.subView.frame).to(equal(CGRect(x: -10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }

            it("transluscent navigationbar 3") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).right(10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                let screenSize = mainView.frame.size
                expect(mainView.subView.frame).to(equal(CGRect(x: screenSize.width - 100 - 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }

            it("transluscent navigationbar 4") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).right(-10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                let screenSize = mainView.frame.size
                expect(mainView.subView.frame).to(equal(CGRect(x: screenSize.width - 100 + 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }

            it("transluscent navigationbar 5") {
                let mainView = viewController.mainView
                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(-20).left(-10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                expect(mainView.subView.frame).to(equal(CGRect(x: -10, y: -20, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 44, width: 40, height: 40)))
            }
        }
    }
}

class PinSafeAreaWithOptInModeSpec: QuickSpec {
    override func spec() {
        var viewController: TestViewController2!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            Pin.safeAreaInsetsDidChangeMode = .optIn
            viewController = TestViewController2()
            navigationController = UINavigationController(rootViewController: viewController)
        }

        afterEach {
            Pin.safeAreaInsetsDidChangeMode = .disable
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("using Pin.safeAreaInsetsDidChangeMode = .optIn") {
            it("should not call safeAreaInsetsDidChange()") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).left(10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                if #available(iOS 11.0, tvOS 11.0, *) {
                    expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                    expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0
                } else {
                    // Should equal 0, because in optIn mode 'safeAreaInsetsDidChange' is called
                    // only if the UIView implement the PinSafeAreaInsetsUpdate protocol. Which is
                    // not the case with TestView2.
                    expect(mainView.safeAreaInsetsDidChangeCalledCount) == 0
                    expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) == 0
                }

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                expect(mainView.subView.frame).to(equal(CGRect(x: 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }
        }
    }
}

class PinSafeAreaWithOptInInsetsUpdateModeSpec: QuickSpec {
    override func spec() {
        var viewController: TestInsetsUpdateViewController!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            viewController = TestInsetsUpdateViewController()
            navigationController = UINavigationController(rootViewController: viewController)
        }

        afterEach {
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("using Pin.safeAreaInsetsDidChangeMode = .optIn") {
            it("should not call safeAreaInsetsDidChange()") {
                Pin.safeAreaInsetsDidChangeMode = .optIn
                
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).left(10).size(100)
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
//                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                expect(mainView.subView.frame).to(equal(CGRect(x: 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }
        }
    }
}

class PinSafeAreaTabBarControllerSpec: QuickSpec {
    override func spec() {
        var viewController: TestViewController2!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            Pin.safeAreaInsetsDidChangeMode = .always

            viewController = TestViewController2()

            let tabbarController = UITabBarController()
            tabbarController.setViewControllers([viewController], animated: false)

            navigationController = UINavigationController(rootViewController: tabbarController)
        }

        afterEach {
            Pin.safeAreaInsetsDidChangeMode = .disable
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("navigationbar + tabbar + subview") {
            it("translucent navigation bar") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.top(10).left(10).size(100)
                }

//                navigationController.navigationBar.barStyle = .blackTranslucent
                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 49.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 34.0, left: 0.0, bottom: 0.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                let screenSize = mainView.frame.size
                expect(mainView.frame).to(equal(CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)))
                expect(mainView.subView.frame).to(equal(CGRect(x: 10, y: 10, width: 100, height: 100)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 34, width: 40, height: 40)))
            }
        }

        describe("navigationbar + tabbar + subview") {
            it("transluscent navigationbar 2") {
                let mainView = viewController.mainView

                mainView.layoutOffsetViewClosure = { (_ subView: UIView, _ parent: UIView) in
                    subView.pin.all()
                }

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount) > 0

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 49.0, right: 0.0)))
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 49.0, right: 0.0)))
                expect(mainView.subView.subViewB!.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                let screenSize = mainView.frame.size
                expect(mainView.subView.frame).to(equal(CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)))
                expect(mainView.subView.subViewB!.frame).to(equal(CGRect(x: 0, y: 44, width: 40, height: 40)))
            }
        }
    }
}

class PinSafeAreaScrollViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: TestScrollViewController!
        var navigationController: UINavigationController!
        var window: UIWindow!

        beforeEach {
            Pin.safeAreaInsetsDidChangeMode = .always
            viewController = TestScrollViewController()
            navigationController = UINavigationController(rootViewController: viewController)
        }

        afterEach {
            Pin.safeAreaInsetsDidChangeMode = .disable
            viewController = nil
            navigationController = nil
            window = nil
        }

        func setupWindow(with viewController: UIViewController) {
            window = UIWindow()
            window.rootViewController = viewController
            window.addSubview(viewController.view)
            window.makeKeyAndVisible();

            // Testing UIViewController's layout methods is kind of bad
            // but needed in our case so we need to wait some time
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        describe("navigationbar + scrollview") {
            it("translucent navigation bar") {
                let mainView = viewController.mainView

                navigationController.navigationBar.isTranslucent = true
                setupWindow(with: navigationController)

                // MATCH safeAreaInsets!
                expect(mainView.safeAreaInsetsDidChangeCalledCount) > 0
                expect(mainView.subView.safeAreaInsetsDidChangeCalledCount).to(equal(0))

                expect(mainView.pin.safeArea).to(equal(UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)))

                // subView is inside a UIScrollView, its safeArea should be .zero
                expect(mainView.subView.pin.safeArea).to(equal(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)))

                let screenSize = mainView.frame.size
                expect(mainView.frame).to(equal(CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)))
                expect(mainView.scrollView.frame).to(equal(CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)))
                expect(mainView.subView.frame).to(equal(CGRect(x: 0, y: 0, width: 100, height: 100)))
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
fileprivate class TestViewController2: UIViewController {
    var mainView: TestView2 { return self.view as! TestView2 }
    override func loadView() {
        self.view = TestView2()
    }
}

class TestView2: UIView {
    fileprivate let subView = SubView(name: "SubViewA", addSubView: true)
    var safeAreaInsetsDidChangeCalledCount: Int = 0
    var layoutOffsetViewClosure: ((_ subView: UIView, _ parent: UIView) -> Void)?

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(subView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func safeAreaInsetsDidChange() {
        safeAreaInsetsDidChangeCalledCount += 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubView()
    }

    private func layoutSubView() {
        assert(layoutOffsetViewClosure != nil)
        layoutOffsetViewClosure?(subView, self)

        subView.layoutIfNeeded()
        subView.subViewB?.layoutIfNeeded()
    }
}

class SubView: UIView {
    fileprivate let name: String
    var safeAreaInsetsDidChangeCalledCount: Int = 0
    var subViewB: SubView?

    init(name: String, addSubView: Bool) {
        self.name = name

        super.init(frame: .zero)
        backgroundColor = .red

        if addSubView {
            subViewB = SubView(name: "SubViewB", addSubView: false)
            subViewB?.backgroundColor = .yellow
            addSubview(subViewB!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func safeAreaInsetsDidChange() {
        safeAreaInsetsDidChangeCalledCount += 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        subViewB?.pin.top(pin.safeArea).left(pin.safeArea).size(40)
    }
}

fileprivate class TestScrollViewController: UIViewController {
    var mainView: TestScrollView { return self.view as! TestScrollView }
    override func loadView() {
        self.view = TestScrollView()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
fileprivate class TestInsetsUpdateViewController: UIViewController {
    var mainView: TestInsetsUpdateView { return self.view as! TestInsetsUpdateView }
    override func loadView() {
        self.view = TestInsetsUpdateView()
    }
}

class TestInsetsUpdateView: UIView, PinSafeAreaInsetsUpdate {
    fileprivate let subView = SubView(name: "SubViewA", addSubView: true)
    var safeAreaInsetsDidChangeCalledCount: Int = 0
    var layoutOffsetViewClosure: ((_ subView: UIView, _ parent: UIView) -> Void)?

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(subView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func safeAreaInsetsDidChange() {
        safeAreaInsetsDidChangeCalledCount += 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubView()
    }

    private func layoutSubView() {
        assert(layoutOffsetViewClosure != nil)
        layoutOffsetViewClosure?(subView, self)

        subView.layoutIfNeeded()
        subView.subViewB?.layoutIfNeeded()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class TestScrollView: UIView {
    let scrollView = UIScrollView()
    let subView = SubView(name: "SubViewA", addSubView: true)
    var safeAreaInsetsDidChangeCalledCount: Int = 0

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(subView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func safeAreaInsetsDidChange() {
        safeAreaInsetsDidChangeCalledCount += 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubView()
    }

    private func layoutSubView() {
        super.layoutSubviews()

        scrollView.pin.all()
        subView.pin.top().left().size(100)

        scrollView.layoutIfNeeded()
        subView.layoutIfNeeded()
    }
}
