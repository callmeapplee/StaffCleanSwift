//
//  FooterView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 16/10/23.
//

import Foundation
import UIKit

class FooterView: UIView {
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    func hideLoader(){
        loader.stopAnimating()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
