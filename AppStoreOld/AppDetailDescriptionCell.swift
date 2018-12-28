//
//  AppDetailDescriptionCell.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 27/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell: BaseCell {
    
    var app: App? {
        didSet {
            guard let descriptionText = app?.desc else { return }
            let helper = Helper()
            let attributedText = helper.descriptionAttributedText(desc: descriptionText)
            textView.attributedText = attributedText
        }
    }
    
    func descriptionAttributedText(desc: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttributes([.paragraphStyle: style], range: range)
        
        attributedText.append(NSMutableAttributedString(string: desc, attributes: [.font: UIFont.systemFont(ofSize: 11), .foregroundColor: UIColor.darkGray ]))
        return attributedText
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "SAMPLE DESCRIPTION"
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLineView)
        
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
