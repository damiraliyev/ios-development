//
//  ProductsViewController.swift
//  GoodAsOldPhones
//
//  Created by Damir Aliyev on 14.09.2022.
//

import Foundation
import UIKit

class ProductsViewController: UIViewController {
    
    typealias Model = ProductCell.Model
    
    let tableView = UITableView()
//    Model(, productName: "1907 Wall Set"), Model(imageView: "image-cell2", productName: "1921 Dial Phone"), Model(imageView: "image-cell3", productName: "1937 Desk Set"), Model(imageView: "image-cell4", productName: "1984 Moto Portable")]
    let products: [ProductCell.Model] = [Model(imageName: "image-cell1", productName: "1907 Wall Set"), Model(imageName: "image-cell2", productName: "1921 Dial Phone"), Model(imageName: "image-cell3", productName: "1937 Desk Set"), Model(imageName: "image-cell4", productName: "1984 Moto Portable")]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        setup()
        layout()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        tableView.rowHeight = CGFloat(ProductCell.rowHeight)
    }
    
    func layout() {
        
        
        view.addSubview(tableView)
        
        //tableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func toImage(_ imageName: String) -> UIImageView {
        let imageView = UIImageView()
        let image = UIImage(named: imageName)
        imageView.image = image
        
        
        return imageView
    }
}

extension ProductsViewController: UITableViewDelegate {
    
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.configure(vm: products[indexPath.row])
        return cell
    }
    
    
}
