import UIKit

// extension DisplayProtocol where Self: UIViewController {
// throws a compilation error "Abort trap: 6".
// workaround: casting self to UIViewController
extension DisplayProtocol {
    func displayError(_ error: Error) {
        if case let .errorResponse(lastFmError) = error as? HTTPError, lastFmError.error == LastFmError.Codes.invalidApiKey, let vc = self as? UIViewController {
            vc.showAlert(title: "Invalid API Key", message: "\(lastFmError.message)\nPlease, provide a valid key in LastFm section of Settings app.")
            return
        }
        
        print("Error: \(error.localizedDescription)")
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
