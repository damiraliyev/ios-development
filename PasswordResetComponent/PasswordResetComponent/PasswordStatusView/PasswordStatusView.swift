//
//  PasswordStatusView.swift
//  PasswordResetComponent
//
//  Created by Damir Aliyev on 17.08.2022.
//

import Foundation
import UIKit

class PasswordStatusView: UIView{
    
    let stackView = UIStackView()
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let criteriaLabel = UILabel()
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowercaseCriteriaView = PasswordCriteriaView(text: "lowercase letter (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterView = PasswordCriteriaView(text: "special character (e.g.!@#$%^&)")
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 200, height: 200)
    }
}

extension PasswordStatusView{
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
//        stackView.backgroundColor = .systemRed
        stackView.distribution = .equalCentering
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterView.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
//        criteriaLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.textColor = UIColor.secondaryLabel
        criteriaLabel.attributedText = makeCriteriaLabel()
    }
    
    func layout(){
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowercaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterView)
    
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
        
    
        
    }
    func makeCriteriaLabel() -> NSAttributedString{
        let boldTextAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.preferredFont(forTextStyle: .subheadline), .foregroundColor: UIColor.label]
        let defaultTextAttributes: [NSAttributedString.Key:Any] = [.font: UIFont.preferredFont(forTextStyle: .subheadline), .foregroundColor: UIColor.secondaryLabel]
        
        let rootString = NSMutableAttributedString(string: "Use at least ", attributes: defaultTextAttributes)
        let boldString = NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes)
        let nextPart = NSAttributedString(string: "criteria when setting this password", attributes: defaultTextAttributes)
        
        rootString.append(boldString)
        rootString.append(nextPart)
        return rootString
    }
}
