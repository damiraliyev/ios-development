//
//  CalculatorViewController.swift
//  CalculatorProgrammatically
//
//  Created by Damir Aliyev on 18.09.2022.
//

import UIKit


class CalculatorViewController: UIViewController {

    let displayLabel = makeLabel(withText: "0")
    
    let parentStackView = makeStackView(axis: .vertical)
    
    let firstStackView = makeStackView(axis: .horizontal)
    let secondStackView = makeStackView(axis: .horizontal)
    let thirdStackView = makeStackView(axis: .horizontal)
    let fourthStackView = makeStackView(axis: .horizontal)
    let fifthStackView = makeStackView(axis: .horizontal)
    let additionalStack = makeStackView(axis: .horizontal)
    
    //MARK: - FIRST ROW BUTTONS
    let clearButton = makeButton(withText: "C", color: .systemGray)
    let changeSignButton = makeButton(withText: "+/-", color: .systemGray)
    let percentButton = makeButton(withText: "%", color: .systemGray)
    let divisionButton = makeButton(withText: "÷", color: .systemOrange)
    
    //MARK: - SECOND ROW BUTTONS
    let button7 = makeButton(withText: "7", color: .darkGray)
    let button8 = makeButton(withText: "8", color: .darkGray)
    let button9 = makeButton(withText: "9", color: .darkGray)
    let multiplyButton = makeButton(withText: "x", color: .systemOrange)
    
    //MARK: -THIRD ROW BUTTONS
    let button4 = makeButton(withText: "4", color: .darkGray)
    let button5 = makeButton(withText: "5", color: .darkGray)
    let button6 = makeButton(withText: "6", color: .darkGray)
    let subtractButton = makeButton(withText: "-", color: .systemOrange)
    
    //MARK: -Fourth ROW BUTTONS
    let button1 = makeButton(withText: "1", color: .darkGray)
    let button2 = makeButton(withText: "2", color: .darkGray)
    let button3 = makeButton(withText: "3", color: .darkGray)
    let addButton = makeButton(withText: "+", color: .systemOrange)
    
    //MARK: -Fifth ROW BUTTONS
    let button0 = makeButton(withText: "0", color: .darkGray)
    let dotButton = makeButton(withText: ".", color: .darkGray)
    let equalsButton = makeButton(withText: "=", color: .systemOrange)
    
    var digitButtons = [UIButton]()
    var oneActionOperations = [UIButton]()
    var operationButtons = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        digitButtons += [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9]
        oneActionOperations += [clearButton, changeSignButton, percentButton, dotButton]
        operationButtons += [addButton, subtractButton, multiplyButton, divisionButton]
        setup()
        layout()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(dotButton.bounds.size.width)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        parentStackView.setCustomSpacing(20, after: displayLabel)
    }
    
    func setup() {
        fifthStackView.distribution = .fillEqually
        displayLabel.adjustsFontSizeToFitWidth = true
        changeSignButton.titleLabel?.attributedText = makeSignChangerDesign()
        changeSignButton.titleLabel?.textAlignment = .center

    }
    
    func layout() {
        // Adding parent stack to the view
        view.addSubview(parentStackView)
        parentStackView.addArrangedSubview(displayLabel)
        
        // We will add other stacks to parentStackView
        parentStackView.addArrangedSubview(firstStackView)
        parentStackView.addArrangedSubview(secondStackView)
        parentStackView.addArrangedSubview(thirdStackView)
        parentStackView.addArrangedSubview(fourthStackView)
        parentStackView.addArrangedSubview(fifthStackView)
        
        firstStackView.addArrangedSubview(clearButton)
        firstStackView.addArrangedSubview(changeSignButton)
        firstStackView.addArrangedSubview(percentButton)
        firstStackView.addArrangedSubview(divisionButton)
       
        secondStackView.addArrangedSubview(button7)
        secondStackView.addArrangedSubview(button8)
        secondStackView.addArrangedSubview(button9)
        secondStackView.addArrangedSubview(multiplyButton)
        
        
        thirdStackView.addArrangedSubview(button4)
        thirdStackView.addArrangedSubview(button5)
        thirdStackView.addArrangedSubview(button6)
        thirdStackView.addArrangedSubview(subtractButton)
        
        fourthStackView.addArrangedSubview(button1)
        fourthStackView.addArrangedSubview(button2)
        fourthStackView.addArrangedSubview(button3)
        fourthStackView.addArrangedSubview(addButton)
        
        
        additionalStack.addArrangedSubview(dotButton)
        additionalStack.addArrangedSubview(equalsButton)
        fifthStackView.addArrangedSubview(button0)
        fifthStackView.addArrangedSubview(additionalStack)
        
        
        
        
        NSLayoutConstraint.activate([
            
            parentStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 15),
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    

    func showPressedButton(sender: UIButton) {
        sender.alpha = 0.7
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 1
        }
    }
    
    func makeSignChangerDesign() -> NSMutableAttributedString {
        let plusAttribute: [NSAttributedString.Key: Any] = [.baselineOffset: 12, .font: UIFont.preferredFont(forTextStyle: .title2)]
        let dividerAttribute: [NSAttributedString.Key: Any] = [.baselineOffset: 5,.font: UIFont.preferredFont(forTextStyle: .title1)]
        let minusAttribute: [NSMutableAttributedString.Key: Any] = [.baselineOffset: 1,.font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        
        let rootString = NSMutableAttributedString(string: "+", attributes: plusAttribute)
        let divider = NSAttributedString(string: "/", attributes: dividerAttribute)

        let minusString = NSAttributedString(string: "-", attributes: minusAttribute)
        
        rootString.append(divider)
        rootString.append(minusString)
        
        return rootString
    }
    
    }


func makeButton(withText text: String, color: UIColor) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.backgroundColor = color
    button.clipsToBounds = true
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    return button
}


func makeStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = axis
    stackView.spacing = 3
    stackView.distribution = .fillEqually
    
    return stackView
}


func makeLabel(withText text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    
    label.textAlignment = .right
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 70, weight: .light)
    label.adjustsFontSizeToFitWidth = true

    return label
}
