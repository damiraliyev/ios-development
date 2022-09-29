//
//  ProductCell.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    struct Model {
        
        let imageName: String
        let productName: String
        let fullScreenImage: String
    }
    
    static let reuseId = "ProducCellId"
    static let rowHeight = 110
    
    var phoneImageView = UIImageView()
    var name = UILabel()
    let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.image = UIImage(named: "image-cell1")
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "1907 Wall Set"
        name.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: nil)
        name.adjustsFontSizeToFitWidth = true
        
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")
        chevronImageView.image = chevronImage
        
    }
    
    func layout() {
        contentView.addSubview(phoneImageView)
        contentView.addSubview(name)
        contentView.addSubview(chevronImageView)
        
        //phoneImageView
        NSLayoutConstraint.activate([
            phoneImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            phoneImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        //name
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 32),
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        //chevronImageView
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 2),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    func configure(vm: Model) {
        phoneImageView.image = UIImage(named: vm.imageName)
        name.text = vm.productName
    }
    
}
