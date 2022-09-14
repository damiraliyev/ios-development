//
//  ProductViewController.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {

    let phoneName = UILabel()
    let addToCartButton = UIButton()
    let phoneImageView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setup()
        layout()
    }
    
    func setup() {
        phoneName.translatesAutoresizingMaskIntoConstraints = false
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.setImage(UIImage(named: "button-addtocart"), for: .normal)
        
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
    func layout() {
        view.addSubview(phoneImageView)
        view.addSubview(phoneName)
        view.addSubview(addToCartButton)
        
        NSLayoutConstraint.activate([
            phoneImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phoneImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phoneImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phoneImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            phoneName.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            phoneName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalToSystemSpacingBelow: phoneName.bottomAnchor, multiplier: 4),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setProductInformation(productName: String, imageName: String) {
        phoneImageView.image = UIImage(named: imageName)
        phoneName.text = productName
        phoneName.attributedText = NSMutableAttributedString(string: productName, attributes: [.font: UIFont.preferredFont(forTextStyle: .title2).withTraits(traits: .traitBold)])
    }
    
    
}
