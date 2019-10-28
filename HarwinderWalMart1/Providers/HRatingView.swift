//
//  HRatingView.swift
//
//  Created by mac on 14/04/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

 @IBDesignable class HRatingView: UIView {
    @IBOutlet var imgVw1: UIImageView!
   
    //MARK: Add properties to Inspector
    @IBInspectable
    var rating:Float = 0.0 {
        didSet {
            if(rating > 0){
                setUpButtons()
            }
        }
    }
    @IBInspectable
    var imageInteraction:Bool = true {
        didSet {
            if(!imageInteraction){
                setUpButtons()
            }
        }
    }

     //MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    init(rating:Float,frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setUpButtons()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for childView in self.subviews {
            if childView is UIImageView {
            let tap = UITapGestureRecognizer(target: self, action: #selector(viewclick))
            tap.numberOfTapsRequired = 1
            childView.addGestureRecognizer(tap)
            }
        }
    }
    
    private func setUpButtons() {
        for childView in self.subviews {
            if childView is UIImageView {
                let tempimgVw: UIImageView = childView as! UIImageView
                if(tempimgVw.tag < Int((rating + 1 + 100))){
                    tempimgVw.image = UIImage(named: "fullstar")
                }
            }
        }
        if(ceil(rating) != floor(rating)){
            let tempImage: UIImageView =  self.viewWithTag(Int(rating + 1 + 100)) as! UIImageView
            tempImage.image = UIImage(named: "halfstar")
        }
        
    }
    
     //MARK: HRatingView Action Handlers
    @objc func viewclick(id:UIGestureRecognizer){
        if(self.imageInteraction){
        rating = 0
        let imgView: UIImageView = id.view as! UIImageView
        let point:CGPoint = id.location(in: imgView)
        //print(point)
        for childView in self.subviews {
            if childView is UIImageView {
                let tempimgVw: UIImageView = childView as! UIImageView
                tempimgVw.image = UIImage(named: "star")
                if(tempimgVw.tag < imgView.tag){
                    tempimgVw.image = UIImage(named: "fullstar")
                    rating = rating + 1
                }
            }
        }
        if(point.x < imgView.frame.size.width/2){
           imgView.image = UIImage(named: "halfstar")
            rating = rating + 0.5
        }
        else{
             imgView.image = UIImage(named: "fullstar")
            rating = rating + 1
        }
        print(rating)
        }
    }
}
