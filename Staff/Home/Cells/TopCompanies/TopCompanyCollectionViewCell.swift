//
//  TopCompanyCollectionViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 08/10/23.
//

import UIKit
import SnapKit
import SDWebImage
protocol TopCompanyCellViewModel {
    var companyLogoUrl:String {get}
}
class TopCompanyCollectionViewCell: UICollectionViewCell {
    static let id = "TopCompanyCollectionViewCell"
    private var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 80, height: 80)))
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    func setup(viewModel:TopCompanyCellViewModel) {
        print(viewModel.companyLogoUrl)
        let url = APIRouter.baseURLForImageString + viewModel.companyLogoUrl
        iconImageView.sd_setImage(with: URL(string: url))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func makeConstraints() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
}
