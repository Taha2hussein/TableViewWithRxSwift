//
//  ProductCell.swift
//  RxSwiftTraining
//
//  Created by A on 07/12/2021.
//

import UIKit
import Kingfisher
class ProductCell: UITableViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData( product:Datum) {
        self.productName.text = product.name
        self.productPrice.text = "\(product.price ?? 0)"
    }
    
    func configure(image: String) {
        
        if let img = URL(string: image){
            DispatchQueue.main.async {
                
                self.productImageView.kf.setImage(with: img)
                
            }
        }
    }
}
