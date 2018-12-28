//
//  Helper.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 27/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit

class Helper {
    
    func descriptionAttributedText(desc: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttributes([.paragraphStyle: style], range: range)
        
        attributedText.append(NSMutableAttributedString(string: desc, attributes: [.font: UIFont.systemFont(ofSize: 11), .foregroundColor: UIColor.darkGray ]))
        return attributedText
    }
}
