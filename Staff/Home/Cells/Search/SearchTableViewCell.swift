//
//  SearchTableViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    static let id = "SearchTableViewCell"
    var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Введите название вакансии".localized()
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.tintColor = UIColor.StaffColors.primary
        return searchBar
    }()
    var filterView:HomeFilterView = {
        let filterView = HomeFilterView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 43)))
        filterView.layer.cornerRadius = 12
        return filterView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        backgroundColor = .clear
        selectionStyle = .none
    }
    func setup(categories:[HomeViewModel.FilterPickerRow], cities:[HomeViewModel.FilterPickerRow]) {
        filterView.setup(categories: categories, cities: cities)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func makeConstraints() {
        contentView.addSubview(searchBar)
        contentView.addSubview(filterView)
        
        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.height.equalTo(43)
        }
        filterView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(searchBar.snp.bottom).inset(-12)
            make.height.equalTo(filterView.frame.height)
            make.bottom.equalToSuperview()
        }
    }

}
