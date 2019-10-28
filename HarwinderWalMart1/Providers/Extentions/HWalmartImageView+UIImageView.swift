//
//  HWalmartImageView+UIImageView.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{

    // MARK: Method loading image from name to UIImageView
    func getProductImageFrom(_ imageName : String){
        let imageURL = kBASELINK+imageName
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
        self.sd_setImage(with: NSURL.init(string: imageURL) as URL?, placeholderImage: UIImage.init())
    }
    
    //MARK: Add preview methods.
    //Add preview on Window with blur background
    //Cancel button and cancel button action
    func setPreview() -> Void {
        self.isUserInteractionEnabled = true
        let tapGesture_image = UITapGestureRecognizer.init(target: self, action: #selector (self.clickTapHandler(id:)))
        tapGesture_image.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture_image)
    }
    
    func setPreviewBlurBackground() -> UIVisualEffectView{
        let screenBound: CGRect = UIScreen.main.bounds
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x:0,y:screenBound.size.height,width:screenBound.width,height:screenBound.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    @objc func clickTapHandler(id: UITapGestureRecognizer){
        let blurEffectView = self.setPreviewBlurBackground()
        let imgview = UIImageView.init(frame: UIScreen.main.bounds)
        imgview.backgroundColor = UIColor.clear
        imgview.image = self.image
        imgview.isUserInteractionEnabled = true
        imgview.contentMode = .scaleAspectFit
        imgview.addSubview(self.addCancelButton())
        blurEffectView.contentView.addSubview(imgview)
        UIView.animate(withDuration: 0.5) {
            blurEffectView.frame = UIScreen.main.bounds
        }
        self.window?.rootViewController?.view.addSubview(blurEffectView)
    }
    
    func addCancelButton() -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:UIScreen.main.bounds.width - 60,y:20,width:40,height:40)
        button.setTitle("X", for: .normal)
        button.setTitleColor(kTO_BLUECOLOR, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.addTarget(self, action: #selector(cancelButtonHandler(id:)), for: .touchDown)
        return button
    }
    
    @objc func cancelButtonHandler(id: UIButton){
        UIView.animate(withDuration: 0.3, animations: {
            (id.superview)?.superview?.superview?.frame = CGRect(x:0,y:UIScreen.main.bounds.size.height,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.width)
        }) { (finished) in
            (id.superview)?.superview?.superview?.removeFromSuperview()
        }
    }
    
}
