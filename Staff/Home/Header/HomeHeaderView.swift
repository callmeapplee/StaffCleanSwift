//
//  HomeHeaderView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit
class HomeHeaderView: UIView {
    private var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Привет".localized()
        return label
    }()
    private var subTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Хорошего дня вам и успехов в поиске".localized()
        return label
    }()
    private var profileIconView:ProfileIconView = {
        let profileIcon = ProfileIconView(frame: CGRect(origin: .zero,
                                                        size: CGSize(width: 70, height: 70)))
        return profileIcon
    }()
    private var labelVStackView:UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func makeConstraints() {
        addSubview(profileIconView)
        addSubview(labelVStackView)
        labelVStackView.addArrangedSubview(titleLabel)
        labelVStackView.addArrangedSubview(subTitleLabel)
        profileIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
            make.height.equalTo(profileIconView.frame.height)
            make.width.equalTo(profileIconView.frame.width)
        }
        labelVStackView.snp.makeConstraints { make in
            make.left.equalTo(profileIconView.snp.right).inset(-20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
