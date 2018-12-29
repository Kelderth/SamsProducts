//
//  HtmlToSwiftExtension.swift
//  Sams Products
//
//  Created by MCS on 12/25/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit

extension String {
    
    // Converts a HTML to String.
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    // Returns tha String version of the HTML code or empy if there is nothing to convert.
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
}
