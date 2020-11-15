 
import Foundation
import UIKit



class VentureOptionCell: UITableViewCell, ConfigurableCell {
    static let reuseId = "VentureOptionCellreuseId"
    @IBOutlet weak var ventureLbl: UILabel!
    @IBOutlet weak var ventureImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none 
        backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }
    
    func configureCell(withItem item: VenturOptionPresentable) {
        self.ventureLbl.text = item.name
        guard let iconName = item.icon, let image = UIImage(named: iconName) else {return}
        self.ventureImg.image = image
    }
}
