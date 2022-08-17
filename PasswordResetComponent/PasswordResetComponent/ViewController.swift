//
//  ViewController.swift
//  PasswordResetComponent
//
//  Created by Damir Aliyev on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    let newPasswordTextField = PasswordTextField(placeholderText: "New password")
//    let newPasswordTextField = PasswordTextField(placeholderText: <#T##String#>)
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension ViewController{
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    
    func layout(){
        stackView.addArrangedSubview(newPasswordTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}

