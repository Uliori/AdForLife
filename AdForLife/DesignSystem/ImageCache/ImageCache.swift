
import UIKit

// NOTE(*): Taken from StackOverFLow
extension UIImageView {
  func imageFromURL(_ url: URL, placeHolder: UIImage?) {
    self.image = placeHolder
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          self.image = placeHolder
        }
        return
      }
      DispatchQueue.main.async {
        if let data = data {
          if let downloadedImage = UIImage(data: data) {
            self.image = downloadedImage
          }
        }
      }
    }).resume()
  }
}
