//
//  ViewController.swift
//  Bankey
//
//  Created by Damir Aliyev on 03.08.2022.
//

import UIKit
protocol LogoutDelegate: AnyObject{
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessage = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String?{
        return loginView.usernameTextField.text
    }
    var password: String?{
        return loginView.passwordTextField.text
    }
    
    var leadingEdgeOnScreen = 16
    var leadingEdgeOffScreen = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController{
    private func style(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        titleLabel.alpha = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        subtitleLabel.alpha = 0

        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign in", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)

        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.textColor = .systemRed
        errorMessage.textAlignment = .center
        errorMessage.numberOfLines = 0
    }
    private func layout(){
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
        
        // Title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(leadingEdgeOffScreen))
        titleLeadingAnchor?.isActive = true
        
        
        // Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
//            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(leadingEdgeOffScreen))
        subtitleLeadingAnchor?.isActive = true
        
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        
    }
}

extension LoginViewController{
    @objc func signInTapped(sender: UIButton){
        errorMessage.isHidden = true
        login()
    }
    
    private func login(){
        guard let username = username, let password = password else{
            assertionFailure("Username or password should never be nil")
            return
        }
        if username.isEmpty || password.isEmpty{
            configureView(withMessage: "Username/password can not be blank")
            return
        }
        if username == "A" && password == "q"{
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }else{
            configureView(withMessage: "Incorrect username or password")
        }
    }
    
    private func configureView(withMessage message: String){
        errorMessage.text = message
        errorMessage.isHidden = false
        shakeButton()
    }
    
    private func shakeButton(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.45, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

// Animation

extension LoginViewController{
    func animate(){
        let duration = 0.5
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeOut){
            self.titleLeadingAnchor?.constant = CGFloat(self.leadingEdgeOnScreen)
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeOut){
            self.subtitleLeadingAnchor?.constant = CGFloat(self.leadingEdgeOnScreen)
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.5)
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut){
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.5)
        
    }
}
