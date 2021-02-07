import UIKit

protocol GCAlertPresenter_Protocol {
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String)
}

class GCAlertPresenter: GCAlertPresenter_Protocol {
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        from.present(alertController, animated: true, completion: nil)
    }
}
