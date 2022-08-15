//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Damir Aliyev on 09.08.2022.
//

import UIKit

class AccountSummaryHeaderView: UIView{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let shakeyBell = ShakeyBellView()
    
    struct ViewModel{
        let welcomeMessage: String
        let name: String
        let date: Date
        
        var dateFormatted: String{
            return date.monthDayYearString
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit(){
        let bundle =  Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupShakeyBell()
    }
    
    private func setupShakeyBell(){
        shakeyBell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBell)
        
      
        
        NSLayoutConstraint.activate([
            shakeyBell.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(viewModel vm: ViewModel){
            self.welcomeLabel.text = vm.welcomeMessage
            self.nameLabel.text = vm.name
            self.dateLabel.text = vm.dateFormatted
    }
   
}
