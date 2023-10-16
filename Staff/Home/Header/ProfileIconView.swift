//
//  ProfileIconView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit
class ProfileIconView: UIView {
    private var profileIconButton:UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 50, height: 50)))
        button.layer.borderWidth = 3
        button.backgroundColor = .cyan
        button.layer.borderColor = UIColor.StaffColors.primary.cgColor
        return button
    }()
    private var notificationCountButton:UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 19, height: 19)))
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .systemGreen
        return button
    }()
    private func setupViews() {
        profileIconButton.layer.cornerRadius = profileIconButton.frame.width / 2
        notificationCountButton.layer.cornerRadius = notificationCountButton.frame.width / 2
        addSubview(profileIconButton)
        addSubview(notificationCountButton)
        profileIconButton.snp.makeConstraints { make in
            make.height.equalTo(profileIconButton.frame.height)
            make.width.equalTo(profileIconButton.frame.width)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        notificationCountButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.height.equalTo(notificationCountButton.frame.height)
            make.width.equalTo(notificationCountButton.frame.width)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
