//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Damir Aliyev on 11.08.2022.
//

import Foundation
import UIKit

extension UITextField{
    
    func enablePasswordToggle(){
        let passwordToggleButton = UIButton(type: .custom)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .primaryActionTriggered)
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(sender: UIButton){
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    
}
