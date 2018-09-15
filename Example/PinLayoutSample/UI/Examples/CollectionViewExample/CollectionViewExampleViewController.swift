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
//
// Created by Luc Dion on 2017-10-31.

import UIKit

struct House {
    let name: String
    let price: String
    let distance: Int
    let mainImageURL: URL
}

class CollectionViewExampleViewController: UIViewController {
    private var mainView: CollectionViewExampleView {
        return self.view as! CollectionViewExampleView
    }

    init(pageType: PageType) {
        super.init(nibName: nil, bundle: nil)
        
        title = pageType.title

        // This property is used only on iOS 7/8/9/10. See https://developer.apple.com/documentation/uikit/uiviewcontroller/1621372-automaticallyadjustsscrollviewin
        automaticallyAdjustsScrollViewInsets = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = CollectionViewExampleView()
        mainView.configure(houses: [
            House(name: "Castlecrag House",
                  price: "1,500,000$",
                  distance: 12,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/76/cc/b4/76ccb45bc61b098c7b9b75de62fcf533--house-design-campo-grande.jpg")!),
            House(name: "Port Ludlow House",
                  price: "1,240,000$",
                  distance: 15,
                  mainImageURL: URL(string: "https://st.hzcdn.com/simgs/f271957f001074d1_4-3434/modern-exterior.jpg")!),
            House(name: "Modern Facade boxes House",
                  price: "950,000$",
                  distance: 22,
                  mainImageURL: URL(string: "https://i.pinimg.com/originals/10/b2/cd/10b2cdbf28cef49281463998dda20796.jpg")!),
            House(name: "Contemporary Modern Home",
                  price: "1,456,000$",
                  distance: 32,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/5e/8f/0b/5e8f0b24f19624754d2aa37968217d5d--architecture-house-design-modern-house-design.jpg")!),
            House(name: "Angel House",
                  price: "932,000$",
                  distance: 82,
                  mainImageURL: URL(string: "https://i.pinimg.com/736x/6d/6c/ab/6d6cab9db70117727e3eb2adf0dbc080--small-modern-house-plans-modern-houses.jpg")!)
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainView.viewOrientationDidChange()
    }
}
