//
//  AbstractViewController.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {

    var lbl_title: UILabel!
    var viewBarTop: UIView!
    var barbuttonLeft: UIButton!
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.addTopViewConstraints()
        self.updateOnNetworkChange()
    }
    
    func setUI() -> Void {
            viewBarTop = UIView(frame:CGRect.zero)
            viewBarTop.backgroundColor = kTO_BLUECOLOR
            viewBarTop.layer.shadowOpacity = 0.5
            viewBarTop.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.view.addSubview(viewBarTop)

            barbuttonLeft = UIButton.init(type: UIButton.ButtonType.custom)
            barbuttonLeft.frame =  CGRect(x:10,y:32 + heightVar,width:30,height:30 )
            barbuttonLeft.contentHorizontalAlignment  = .left
            barbuttonLeft.titleLabel?.font = UIFont (name: kHWALMARTAPP_FONTSTYLE, size: 16)
            barbuttonLeft.isHidden = true
            barbuttonLeft.setImage(UIImage(named: kTo_Back), for: .normal)
            barbuttonLeft.addTarget(self, action:#selector(self.leftbarbutton_handler(id:)), for: UIControl.Event.touchDown)
            viewBarTop.addSubview(barbuttonLeft)
            
            lbl_title = UILabel(frame: CGRect(x: 50, y:37 + heightVar, width:screenWidth-100,height:19))
            lbl_title.backgroundColor = UIColor.clear
            lbl_title.textColor = .white
            lbl_title.font = UIFont (name: kkHWALMARTAPP_FONTBOLD, size: 16)
            lbl_title.adjustsFontSizeToFitWidth = true
            lbl_title.textAlignment  = NSTextAlignment.center
            viewBarTop.addSubview(lbl_title)
        
        let viewLeftSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(viewLeftSwipeGesture_Handler(swipeGesture:)))
        viewLeftSwipeGesture.direction = .left
                         self.view.isUserInteractionEnabled = true
                         self.view.addGestureRecognizer(viewLeftSwipeGesture)
        
        let viewRightSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(viewRightSwipeGesture_Handler(swipeGesture:)))
               viewRightSwipeGesture.direction = .right
                                self.view.isUserInteractionEnabled = true
                                self.view.addGestureRecognizer(viewRightSwipeGesture)
        
        SceneDelegate.shared?.addNotificationBanner()
    }
    
    // MARK: - Methods To Override
    override var preferredStatusBarStyle : UIStatusBarStyle {
              return UIStatusBarStyle.lightContent
          }
    
    @objc func viewLeftSwipeGesture_Handler(swipeGesture: UIGestureRecognizer){
       
    }
    
    @objc func viewRightSwipeGesture_Handler(swipeGesture: UIGestureRecognizer){
           _ = self.navigationController?.popViewController(animated: true)
       }
    
    @objc func leftbarbutton_handler(id: UIButton){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func onconnectingNetwork(){
        self.network.reachability.whenReachable = { reachability in
                if((SceneDelegate.shared?.banner_VW.isHidden)!){
                    SceneDelegate.shared?.showBanner(bannerTitle: kNETWORK_AVAILABLE)
                }
        }
    }
    
    func onLosingNetwork(){
        self.network.reachability.whenUnreachable = { reachability in
                SceneDelegate.shared?.showBanner(bannerTitle: kNETWORK_UNAVAILABLE)
              }
    }
    
    func updateOnNetworkChange(){
        self.onconnectingNetwork()
        self.onLosingNetwork()
    }
    
     // MARK: - UI Constraints
    func addTopViewConstraints(){
        let horizontalConstraint = NSLayoutConstraint(item: viewBarTop!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
           let bottomConstraint = NSLayoutConstraint(item: self.view!, attribute:.topMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewBarTop, attribute: .topMargin, multiplier: 1, constant: 0)
           let widthConstraint = NSLayoutConstraint(item: self.view!, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewBarTop, attribute: .width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: viewBarTop!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64 + heightVar)
           viewBarTop.translatesAutoresizingMaskIntoConstraints = false
           self.view.addConstraints([horizontalConstraint, bottomConstraint, widthConstraint, heightConstraint])
       }
}



