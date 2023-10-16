//
//  TopCategoryCollectionViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 06/10/23.
//

import UIKit
import SnapKit
import SDWebImage
protocol TopCategoryCellViewModel {
    var categoryIconUrl:String {get}
    var categoryName:String {get}
}
class TopCategoryCollectionViewCell: UICollectionViewCell {
    static let id = "TopCategoryCollectionViewCell"
    private var iconParentView:UIView = {
       let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 74, height: 74)))
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.numberOfLines = 0
        label.text = "temp"
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(viewModel:TopCategoryCellViewModel) {
        nameLabel.text = viewModel.categoryName
        let url = APIRouter.baseURLForImageString + viewModel.categoryIconUrl
        iconImageView.sd_setImage(with: URL(string: url))
    }
    private func makeConstraints() {
        contentView.addSubview(iconParentView)
        contentView.addSubview(nameLabel)
        iconParentView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.width.equalTo(iconParentView.frame.width)
            make.height.equalTo(iconParentView.frame.height)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(iconParentView.snp.bottom).inset(5)
        }
        
        iconParentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview().inset(20)
        }
        
    }
}
