//
//  contactsView.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import Foundation
import UIKit

class ContactView: UIView {
    let contactImageView = UIImageView()
    let contactText = UILabel()
    
    init(contactImageName: String, contactString: String) {
        super.init(frame: .zero)
        contactImageView.image = UIImage(named: contactImageName)
        
        contactText.text = contactString
        contactText.textColor = .label
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
    
    func setup() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        contactText.translatesAutoresizingMaskIntoConstraints = false
        contactText.adjustsFontSizeToFitWidth = true
        
        
    }
    
    func layout() {
        addSubview(contactImageView)
        addSubview(contactText)
        
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: topAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contactText.centerYAnchor.constraint(equalTo: contactImageView.centerYAnchor),
            contactText.leadingAnchor.constraint(equalToSystemSpacingAfter: contactImageView.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalTo: contactText.trailingAnchor)
        ])
    }
    
}
