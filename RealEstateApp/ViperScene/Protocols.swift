 

import Foundation
import UIKit
import RealmSwift


protocol VenturesView: class {
  var presenter: VenturesPresentation! {get}
  func reloadData()
  func updateCells(atIndexpaths indexPaths: [IndexPath], withAnimationType type: VenturesPresenter.AnimationType)
}
protocol VenturesUseCase: class {
    func getVenturesData(completion: @escaping(Result<RealEstatePartuculars, ApiError>) -> Void)
}

protocol VenturesWireframe: class {
    var view: UIViewController? {get}
    func showAlert(withMessage message: String, andSubtitle sub: String)
}

protocol VenturesPresentation: class {
    var view: VenturesView? {get}
    var router: VenturesWireframe? {get}
    var interactor: VenturesUseCase? {get}
    func configure(modelforIndexpath indexpath: IndexPath, toCell cell: ConfigurableCell)
    func configure(modelforSection section: Int, toHeader header: ConfigurableHeader)
    func finishSelecting()
    func cellCount(forSection sec: Int) -> Int
    func didSelectHeader(_ tag: Int)
    func didselectCell(ofIndexPath indexpath: IndexPath)
    var sectionCount: Int {get}
    func viewDidLoad()
    var title: String {get}
}




protocol RealEstatePartuculars {
    var ventures: List<Venture> {get set}
    var exclusions: List<DoubleExclusions> {get set}
}


protocol VenturOptionPresentable {
    var icon: String? {get set}
    var name: String? {get set}
}


protocol ConfigurableCell {
    func configureCell(withItem item: VenturOptionPresentable)
}
