//
//  File.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductListFacade: NSObject {
    
    //MARK: facade for product API
    func fetchProductList(_url:String, completionBlock:@escaping (_ productList: ProductList?, _ error: NSError?) -> Void){
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
        let apiStore: ApiStore = ApiStore()
        let finalUrl: String = kFETCHPRODUCTLISTURL + _url
        apiStore.getdata(_urlLink: finalUrl, completionBlock: { (response, error) in
            if(error == nil){
                let productitemlList: ProductList = ProductList.init(json: response!)
                completionBlock(productitemlList, nil)
            }
            else {
               completionBlock(nil, error)
            }
        })
    }
        else {
             SceneDelegate.shared?.showBanner(bannerTitle: kNETWORK_UNAVAILABLE)
        }
    }
    
}

