//
//  UsViewController.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import Foundation
import UIKit

class UsViewController: UIViewController {
    let scrollView = UIScrollView()
    
    let stack = UIStackView()
    let headerImageView = UIImageView()
    let aboutUsLabel = UILabel()
    let infoLabel = UILabel()
    let availableLabel = UILabel()
    let contactLabel = UILabel()
    
    let contactsStack = UIStackView()
    let mailContact = ContactView(contactImageName: "icon-about-email", contactString: "good-as-old@example.com")
    let phoneContact = ContactView(contactImageName: "icon-about-phone", contactString: "+7-777-777-77-77")
    let websiteContact = ContactView(contactImageName: "icon-about-website", contactString: "www.goodasold.com")
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let logo = UIImage(named: "header-contact")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        setup()
        layout()
    }
    
    func setup() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentViewSize
        scrollView.frame = self.view.bounds
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 25
        
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.image = UIImage(named: "header-contact")
        
        aboutUsLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutUsLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: nil)
        aboutUsLabel.textAlignment = .center
        aboutUsLabel.attributedText = NSMutableAttributedString(string: "About us", attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [ .traitBold])])
        
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text =
        """
           Good as Old Phones returns phones of yesteryear back to their original glory and then gets them into the hands of those who appreciate them most:
        
        
        
             Whether you are looking for a turn-of-the-century wall set or a Zack Morris special, we've got you covered. Giva us a ring and we will get you connected.
        """
        infoLabel.textColor = .label
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        
        availableLabel.translatesAutoresizingMaskIntoConstraints = false
        let availableAttribute: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Avenir-MediumOblique", size: 16)!]
        let availableString = NSAttributedString(string: "Hands-free phones available", attributes: availableAttribute)
        availableLabel.attributedText = availableString
        
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
//        contactLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        contactLabel.textAlignment = .center
        contactLabel.attributedText = NSMutableAttributedString(string: "Contact", attributes: [.font: UIFont.preferredFont(forTextStyle: .title1).withTraits(traits: [ .traitBold])])
        
        
        contactsStack.translatesAutoresizingMaskIntoConstraints = false
        contactsStack.axis = .vertical
        contactsStack.spacing = 8
    }
    
    func layout() {
        view.addSubview(scrollView)
        containerView.addSubview(headerImageView)
        containerView.addSubview(stack)
        scrollView.addSubview(containerView)
        
        contactsStack.addArrangedSubview(mailContact)
        contactsStack.addArrangedSubview(phoneContact)
        contactsStack.addArrangedSubview(websiteContact)
        
        stack.addArrangedSubview(aboutUsLabel)
        stack.addArrangedSubview(infoLabel)
        stack.addArrangedSubview(availableLabel)
        stack.addArrangedSubview(contactLabel)
        stack.addArrangedSubview(contactsStack)
        
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 6),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension UIFont{
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont{
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    func bold() -> UIFont{
        return withTraits(traits: .traitBold)
    }
}
