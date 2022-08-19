//
//  ViewController.swift
//  PasswordResetComponent
//
//  Created by Damir Aliyev on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let newPasswordTextField = PasswordTextField(placeholderText: "New password")
    let statusView = PasswordStatusView()
    let stackView = UIStackView()
    let confirmPasswordTextField = PasswordTextField(placeholderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        
    }
}

extension ViewController{
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword(){
        let newPasswordValidation: CustomValidation = { text in
            //Empty text
            guard let text = text, !text.isEmpty else{
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            self.statusView.updateDisplay(text)
            
            if !self.statusView.validate(text){
                return (false, "Your password must meet requirements below")
            }
            
            return(true, "")
        }
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
    }
    
    private func setupConfirmPassword(){
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else{
                return (false, "Enter your password")
            }
            
            guard text == self.newPasswordTextField.text else{
                return (false, "Password don't match")
            }
            return (true, "")
        }
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    
    private func setupDismissKeyboardGesture(){
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    @objc func viewTapped(){
        view.endEditing(true)
    }
    
    func style(){
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 10
        statusView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
    }
    
    func layout(){
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}

//MARK: - PasswordTextFieldDelegate

extension ViewController: PasswordTextFieldDelegate{
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField{
            statusView.shouldResetCriteria = false
            _ = sender.validate()
        }else if sender === confirmPasswordTextField{
            _ = sender.validate()
        }
    }
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField{
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
}
