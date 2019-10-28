//
//  File.swift
//  HarwinderWalMart1
//
//  Created by mac on 24/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiStore: NSObject {
    
    func getdata(_urlLink: String, completionBlock: @escaping (_ json: JSON?, _ error: NSError?) -> Void) {
        Alamofire.request(_urlLink).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                completionBlock(resJson as JSON?, nil)
            }
            if responseObject.result.isFailure {
                let error : NSError = responseObject.result.error! as NSError
                completionBlock(nil, error)
            }
        }
    }
}
