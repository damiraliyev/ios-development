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
    
    var alert: UIAlertController?
    
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
        setupKeyboardHiding()
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
                return (false, "Passwords don't match")
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
    
    private func setupKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .primaryActionTriggered)
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


//MARK: - Keyboard

extension ViewController{
    @objc func keyboardWillShow(sender: NSNotification){
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else{ return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY{
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrame = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrame
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){

        view.frame.origin.y = 0
    }
}

//Reset button functions
extension ViewController{
    @objc func resetButtonTapped(sender: UIButton){
        let isValidNewPassword = newPasswordTextField.validate()
        
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword{
            showAlert(title: "Success", message: "You have successfully changed your password!")
        }
    }
    
    func showAlert(title: String, message: String){
        alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        guard let alert = alert else { return }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}


//MARK: Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue }
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue}
    }
    
    func setupNewPasswordTest(){
        return setupNewPassword()
    }
    
    func setupConfirmTest(){
        return setupConfirmPassword()
    }
}
