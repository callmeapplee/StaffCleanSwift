//
//  TopCategoriesTableViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 06/10/23.
//

import UIKit
import SnapKit
class TopCategoriesTableViewCell: UITableViewCell {
    static let id = "TopCategoriesTableViewCell"
    private var topCategories:[TopCategoryCellViewModel] = []
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 110)), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: .zero)
        return collectionView
    }()
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopCategoryCollectionViewCell.self, forCellWithReuseIdentifier: TopCategoryCollectionViewCell.id)
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
    func setup(topCategories:[TopCategoryCellViewModel]) {
        self.topCategories = topCategories
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
extension TopCategoriesTableViewCell: UICollectionViewDelegate {
    
}
extension TopCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 74, height: collectionView.frame.height)
    }
}
extension TopCategoriesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCategoryCollectionViewCell.id, for: indexPath) as! TopCategoryCollectionViewCell
        cell.setup(viewModel: topCategories[indexPath.row])
        return cell
    }
    
    
}
