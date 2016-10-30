import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class API {
    static let random = URL(string: "http://api.giphy.com/v1/stickers/random?api_key=dc6zaTOxFJmzC")!
    static let randomRequest = URLRequest(url: API.random)
}

class JSON {
    static func decode(data: Data) -> [String: Any]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return nil
        }
        return json as? [String: Any]
    }
}

class ImageURL {
    static func from(jsonData data: Data) -> String? {
        if let json = JSON.decode(data: data),
            let data = json["data"] as? [String: Any],
            let imgURL = data["image_url"] as? String {
            return imgURL
        } else {
            return nil
        }
    }
}

class RandomGIF {
    private static func imageProducer() -> SignalProducer<UIImage, NSError> {
        return URLSession.shared.reactive.data(with: API.randomRequest)
            .attemptMap { data, urlResponse -> Result<String, NSError> in
                if let imgURL = ImageURL.from(jsonData: data) {
                    return Result(value: imgURL)
                } else {
                    return Result(error: NSError(domain: "", code: 0, userInfo: nil))
                }
            }
            .attemptMap { url -> Result<UIImage, NSError> in
                if let img = UIImage.gif(url: url) {
                    return Result(value: img)
                } else {
                    return Result(error: NSError(domain: "", code: 1, userInfo: nil))
                }
            }
    }
    
    static func get(_ observer: Observer<UIImage, NSError>) {
        self.imageProducer().start(observer)
    }
}

RandomGIF.get(Observer() { event in
    switch event {
    case let .value(img):
        print("received UIImage")
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: img.size))
        imgView.image = img
        PlaygroundPage.current.liveView = imgView
        
    case .completed:
        print("Done!")
        
    case let .failed(error):
        print("Error: \(error)")
        
    default:
        break
    }
})
