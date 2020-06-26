import UIKit

class AutoSizingViewController: UIViewController {
    private var mainView: AutoSizingView {
        return self.view as! AutoSizingView
    }

    override func loadView() {
        self.view = AutoSizingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomizeContent()
    }

    private func configureNavigationBar() {
        navigationItem.title = "AutoSizing"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Randomize", style: .plain, target: self, action: #selector(randomizeContent))
    }

    @objc
    private func randomizeContent() {
        ContentService.shared.fetchText(numberOfParagraph: 2) { [weak self] (result) in
            guard let strongSelf = self, case let .success(paragraphs) = result else { return }
            strongSelf.mainView.updateTexts(firstText: paragraphs[0], secondText: paragraphs[1])
        }

        ContentService.shared.fetchImage(width: Int.random(in: 200..<500), height: Int.random(in: 200..<500)) { [weak self] (result) in
            guard let strongSelf = self, case let .success(image) = result else { return }
            strongSelf.mainView.updateImage(image)
        }
    }
}
