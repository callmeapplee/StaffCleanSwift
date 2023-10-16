//
//  TopCompaniesTableViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 08/10/23.
//

import UIKit
import SnapKit
class TopCompaniesTableViewCell: UITableViewCell {
    static let id = "TopCompaniesTableViewCell"
    private var topCompanies:[TopCompanyCellViewModel] = []
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 80)), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: .zero)
        return collectionView
    }()
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopCompanyCollectionViewCell.self, forCellWithReuseIdentifier: TopCompanyCollectionViewCell.id)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
        configureCollectionView()
        backgroundColor = .clear
        selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(topCompanies:[TopCompanyCellViewModel]) {
        self.topCompanies = topCompanies
        collectionView.reloadData()
    }
    private func makeConstraints() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(collectionView.frame.height)
        }
    }

}
extension TopCompaniesTableViewCell: UICollectionViewDelegate {
    
}
extension TopCompaniesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}
extension TopCompaniesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCompanyCollectionViewCell.id, for: indexPath) as! TopCompanyCollectionViewCell
        cell.setup(viewModel: topCompanies[indexPath.row])
        return cell
    }
    
    
}
