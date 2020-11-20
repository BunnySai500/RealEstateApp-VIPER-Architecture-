 

import Foundation
import UIKit

class VenturesRouter: VenturesWireframe {
    var view: UIViewController?
     //MARK:  Showing Alert
    func showAlert(withMessage message: String, andSubtitle sub: String){
        guard let vi = view else {
            return
        }
    HelperClass.showAlertWithOneOption(title: message, subTitle: sub, controller: vi) { _ in
    }
    }
    func finishRegistration() {
        view?.navigationController?.pushViewController(ConformationBuilder.makeVc(), animated: true)
    }
}
