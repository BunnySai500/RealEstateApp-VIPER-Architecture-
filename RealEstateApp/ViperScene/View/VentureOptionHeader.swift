 
import Foundation
import UIKit


@IBDesignable
class VentureOptionHeader: UIView, ConfigurableHeader {
    static let reuseId = "VentureOptionHeaderreuseId"
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var selectionLbl: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
       configureView()
    }
    func configureHeader(withVm vm: VenturHeaderViewModel) {
        self.nameLbl.text = vm.name
        self.selectionLbl.text = vm.optionName
    }
   required init?(coder: NSCoder) {
     super.init(coder: coder)
     configureView()
    }

 private func configureView()
 {
    isUserInteractionEnabled = true
     guard let vie = self.loadNib(nibName: "VentureOptionHeader") else{return}
     vie.frame = self.bounds
     vie.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     self.addSubview(vie)
 }
}


extension UIView
{
    func loadNib(nibName: String) -> UIView?
    {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


protocol ConfigurableHeader {
    func configureHeader(withVm vm: VenturHeaderViewModel)
}
