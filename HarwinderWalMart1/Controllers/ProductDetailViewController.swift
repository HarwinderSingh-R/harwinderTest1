//
//  ProductDetailViewController.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductDetailViewController: AbstractViewController {
    
    var productList: [Products] = []
    var itemIndex: Int = 0
    @IBOutlet weak var lbl_ProdName: UILabel!
    @IBOutlet weak var lbl_ProdPrice: UILabel!
    @IBOutlet weak var img_ProdImage: UIImageView!
    @IBOutlet weak var hrtr_ProdRate: HRatingView!
    @IBOutlet weak var lbl_RatingCount: UILabel!
    @IBOutlet weak var lbl_ProdShortDescription: UILabel!
    @IBOutlet weak var lbl_ProdLongDescription: UILabel!
    @IBOutlet weak var lbl_ProdInStockStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.barbuttonLeft.isHidden = false
        self.lbl_title.text = "Product Detail"
        bindingProductInfo()
    }

    func bindingProductInfo(){
        let product: Products = self.productList[itemIndex]
        self.lbl_ProdName.text = product.productName
        self.img_ProdImage.getProductImageFrom(product.productImage!)
        self.img_ProdImage.setPreview()
        self.hrtr_ProdRate.rating = Float(product.reviewRating!)
        self.lbl_ProdPrice.text = product.price
        self.lbl_RatingCount.text = "(" + String(product.reviewCount!) + ")"
        self.lbl_ProdInStockStatus.text = (product.inStock!) ? "Yes" : "No"
        self.lbl_ProdLongDescription.attributedText = product.longDescription?.convertHTMLToAttributedstring()
    }
    
    override func viewLeftSwipeGesture_Handler(swipeGesture: UIGestureRecognizer){
        if(self.itemIndex < self.productList.count - 1){
            self.itemIndex = self.itemIndex + 1
            self.bindingProductInfo()
        }
    }
    
    override func viewRightSwipeGesture_Handler(swipeGesture: UIGestureRecognizer){
        if(self.itemIndex > 0){
            self.itemIndex = self.itemIndex - 1
            self.bindingProductInfo()
        }
    }
}
