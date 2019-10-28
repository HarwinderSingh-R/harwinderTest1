//
//  HBannerView.swift
//  DemoTestApp
//
//  Created by mac on 28/08/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class HBannerView: UIView {

    var btn_Cancel: UIButton!
    var img_TopImage: UIImageView!
    var lbl_Title: UILabel!
    var heightrt: CGFloat = 65
    var heightConstraint : NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         self.setOverview()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    func  setOverview(){
        self.backgroundColor = .systemYellow
        self.addPopUpTitle(titleText: " ")
        self.addCancelButton()
    }
    /*adding cancel button to banner view */
    func addCancelButton()  {
        self.btn_Cancel = UIButton.init(type: .custom)
        self.btn_Cancel.frame = CGRect.zero
        self.btn_Cancel.setTitle("X", for: .normal)
        self.btn_Cancel.setTitleColor(kTO_BLUECOLOR, for: .normal)
        self.btn_Cancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.btn_Cancel.addTarget(self, action: #selector(self.btnCancelHandler(idself:)), for: .touchDown)
        self.addSubview(self.btn_Cancel)
        self.addConstraintsforCancel_btn(newView: self.btn_Cancel)
    }
    
    /*adding title label to banner view */
    func addPopUpTitle(titleText: String)  {
        lbl_Title = UILabel.init()
        lbl_Title.text = titleText
        lbl_Title.textAlignment = .center
        lbl_Title.textColor = UIColor.black
        lbl_Title.textAlignment = .left
        lbl_Title.font = UIFont.boldSystemFont(ofSize: 13)
        lbl_Title.numberOfLines = 2
        self.addSubview(lbl_Title)
        self.addConstraintsforTitleLabel(newView: lbl_Title)
    }

     //MARK: Banner methods
    @objc func btnCancelHandler(idself: UIButton){
        self.hideBanner()
    }
    
    func showBanner(bannerTitle: String)  {
        self.isHidden = false
        lbl_Title.text = bannerTitle
        lbl_Title.textColor = kTO_BLUECOLOR
         self.heightConstraint.constant = 66
        UIView.animate(withDuration: 0.5) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    func hideBanner()  {
        if(self.isHidden == false){
            self.heightConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.superview?.layoutIfNeeded()
            }) { (finished) in
                self.isHidden = true
            }
        }
    }
    
    //MARK: AutoLayout Constraints For SubViews
    func addConstraints(newView: HBannerView, heightr: CGFloat)  {
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heightr)
        newView.translatesAutoresizingMaskIntoConstraints = false
        self.superview?.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func addConstraintsforCancel_btn(newView: UIButton){
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: .trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -5)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: .centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .centerY, multiplier: 1.2, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        newView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

    }
    
    func addConstraintsforTitleLabel(newView: UILabel){
        let horizontalConstraint = NSLayoutConstraint(item: lbl_Title!, attribute: .leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .leading, multiplier: 1, constant: 30)
        let verticalConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lbl_Title, attribute: .top, multiplier: 1, constant: 10)
        let widthConstraint = NSLayoutConstraint(item: lbl_Title!, attribute: .trailing , relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -50)
        heightConstraint = NSLayoutConstraint(item: newView, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 10)
        newView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
 
    }

}
