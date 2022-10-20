//
//  ListViewCell.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/12/22.
//

import UIKit

class ListViewCell: UICollectionViewCell {

    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var flatImg: UIImageView!
    @IBOutlet weak var bathlbl: UILabel!
    @IBOutlet weak var bedlbl: UILabel!
    @IBOutlet weak var arealbl: UILabel!
    @IBOutlet weak var prjNamelbl: UILabel!
    @IBOutlet weak var addresslbl: UILabel!
    @IBOutlet weak var categorylbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(data: ListData) {

        self.pricelbl.text = Utility.shared.currencyFormatter(data: data.attributes.price)

        self.bathlbl.text = String(data.attributes.bathrooms) + (Int(data.attributes.bathrooms)>1 ? "Baths" : "Bath")
        self.bedlbl.text = String(data.attributes.bathrooms) + (Int(data.attributes.bathrooms)>1 ? "Beds" : "Bed")
        self.arealbl.text = String(data.attributes.area_size) + "sqft"
        self.prjNamelbl.text = data.project_name
        self.addresslbl.text = data.address.district + "," + data.address.street_name
        self.categorylbl.text = data.category
        guard let url = URL(string: data.photo) else { return }
        self.flatImg.load(url: url)
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
