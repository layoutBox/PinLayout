import UIKit

class ContentService {
    static let shared = ContentService()

    private init() {}

    func fetchText(numberOfParagraph: Int = 1, completionHandler: ((Result<[String], Error>) -> Void)?) {
        URLSession.shared.dataTask(with: URL(string: "https://baconipsum.com/api/?type=all-meat&paras=\(numberOfParagraph)&start-with-lorem=1")!) { data, _, error in
            guard let data = data, error == nil,
                let paragraphs = try? JSONDecoder().decode([String].self, from: data)
                else {
                    DispatchQueue.main.async {
                        completionHandler?(Result<[String], Error>.failure(error!))
                    }
                    return
                }

            DispatchQueue.main.async {
                completionHandler?(Result<[String], Error>.success(paragraphs))
            }
        }.resume()
    }

    func fetchImage(width: Int, height: Int, completionHandler: ((Result<UIImage, Error>) -> Void)?) {
        URLSession.shared.dataTask(with: URL(string: "https://baconmockup.com/\(width)/\(height)")!) { data, _, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        completionHandler?(Result<UIImage, Error>.failure(error!))
                    }
                    return
                }

            DispatchQueue.main.async {
                completionHandler?(Result<UIImage, Error>.success(image))
            }
        }.resume()
    }
}
