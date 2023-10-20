//
//  HomeFilterView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 18/10/23.
//

import Foundation
import UIKit
import SnapKit
class HomeFilterView:FilterView {
    private var filterButton:UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 33, height: 33)))
        button.backgroundColor = UIColor(red: 0.49, green: 0.92, blue: 0.06, alpha: 1)
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func makeConstraints() {
        addSubview(viewsHStack)
        addSubview(filterButton)
        viewsHStack.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
        }
        filterButton.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(5)
            make.left.equalTo(viewsHStack.snp.right).inset(-10)
            make.width.equalTo(filterButton.frame.width)
            make.height.equalTo(filterButton.frame.height)
        }
    }
}
