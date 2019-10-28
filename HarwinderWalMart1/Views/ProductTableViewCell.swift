//
//  ProductTableViewCell.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_ProductName: UILabel!
    @IBOutlet weak var img_ProductImage: UIImageView!
    @IBOutlet weak var lbl_ProductPrice: UILabel!
    @IBOutlet weak var hrtr_ProductRate: HRatingView!
    @IBOutlet weak var lbl_RatingCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setTableCellUI(product: Products){
        self.lbl_ProductName.text = product.productName!
        self.img_ProductImage.getProductImageFrom(product.productImage!)
        self.lbl_ProductPrice.text = product.price
        self.lbl_RatingCount.text = "(" + String(product.reviewCount!) + ")"
        self.hrtr_ProductRate.rating = Float(product.reviewRating!)
    }
}
