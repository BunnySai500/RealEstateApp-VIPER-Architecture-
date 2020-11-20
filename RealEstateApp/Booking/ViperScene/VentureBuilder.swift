 

import Foundation
import UIKit

//MARK: Venture Builder


class VentureModBuilder {
    static func assenbleVentureModule() -> UIViewController
    {
    let vi = RealEstateBuyingOptionsScreen()
    let ro = VenturesRouter()
    ro.view = vi
    let int = VenturesInteractor()
    let presenter = VenturesPresenter(vi, ro, int)
    vi.presenter = presenter
    return vi
    }
}



