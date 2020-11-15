 

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
struct APIEndPoints {
static let venturesApi =  "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"
}

struct DefaultConstants {
    static let datechange = "isDateChanged"
    static let date = "date"
}


class HelperClass {
    class func showAlertWithOneOption(title:String, subTitle:String, controller: UIViewController, onSelectButton:((Int)->())?) {
        let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                onSelectButton?(1)
            }
        alertController.addAction(action)
        controller.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
