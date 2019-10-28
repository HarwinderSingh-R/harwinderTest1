//
//  HWalmartString+String.swift
//  HarwinderWalMart1
//
//  Created by mac on 25/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import  UIKit

extension String{
    
    // MARK: Method convert HTML string to attributed string
    func convertHTMLToAttributedstring() ->NSAttributedString {
        let data = self.data(using: String.Encoding.unicode)! // mind "!"
       let attrStr = try? NSAttributedString( // do catch
           data: data,
           options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
           documentAttributes: nil)
        return attrStr!
    }

}
