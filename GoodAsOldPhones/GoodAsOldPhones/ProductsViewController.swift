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
    
    let productViewController = ProductViewController()
    
    let tableView = UITableView()
    
    let products: [ProductCell.Model] = [
        Model(imageName: "image-cell1", productName: "1907 Wall Set", fullScreenImage: "phone-fullscreen1"),
        Model(imageName: "image-cell2", productName: "1921 Dial Phone", fullScreenImage: "phone-fullscreen2"),
        Model(imageName: "image-cell3", productName: "1937 Desk Set", fullScreenImage: "phone-fullscreen3"),
        Model(imageName: "image-cell4", productName: "1984 Moto Portable", fullScreenImage: "phone-fullscreen4")]
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productViewController.setProductInformation(productName: products[indexPath.row].productName, imageName: products[indexPath.row].fullScreenImage)
        navigationController?.pushViewController(productViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
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
