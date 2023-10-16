//
//  FilterView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit
class FilterView: UIView {
    private var cityTextField:UITextField = {
        let textField = UITextField()
        textField.tintColor = .clear
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Города".localized()
        return textField
    }()
    private var cityView:UIView = {
       let cityView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 110, height: 33)))
        cityView.backgroundColor = .white
        cityView.layer.cornerRadius = 8
        return cityView
    }()
    private var jobPositionTextField:UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.tintColor = .clear
        textField.placeholder = "Вакансии".localized()
        textField.textAlignment = .justified
        return textField
    }()
    private var jobPositionView:UIView = {
       let cityView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 110, height: 33)))
        cityView.backgroundColor = .white
        cityView.layer.cornerRadius = 8
        return cityView
    }()
    private var filterButton:UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 33, height: 33)))
        button.backgroundColor = UIColor(red: 0.49, green: 0.92, blue: 0.06, alpha: 1)
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.StaffColors.primary
        makeConstraints()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupjobPositionView() {
        let rightIcon = UIImageView(image: UIImage(named: "arrow_down"))
        rightIcon.contentMode = .scaleAspectFill
        jobPositionView.addSubview(jobPositionTextField)
        jobPositionView.addSubview(rightIcon)
        jobPositionTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(7)
        }
        rightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(jobPositionTextField.snp.centerY)
            make.right.equalToSuperview().inset(7)
            make.left.equalTo(jobPositionTextField.snp.right).inset(-5)
            make.width.equalTo(7)
        }
    }
    private func setupCityView() {
        let leftIcon = UIImageView(image: UIImage(named: "location_green"))
        let rightIcon = UIImageView(image: UIImage(named: "arrow_down"))
        rightIcon.contentMode = .scaleAspectFill
        cityView.addSubview(leftIcon)
        cityView.addSubview(cityTextField)
        cityView.addSubview(rightIcon)
        leftIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(10)
        }
        cityTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(leftIcon.snp.right).inset(-5)
        }
        rightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(cityTextField.snp.centerY)
            make.right.equalToSuperview().inset(7)
            make.left.equalTo(cityTextField.snp.right).inset(-5)
            make.width.equalTo(7)
        }
    }
    private func makeConstraints() {
        setupCityView()
        setupjobPositionView()
        addSubview(cityView)
        addSubview(jobPositionView)
        addSubview(filterButton)
        cityView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(cityView.frame.width)
        }
        jobPositionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(cityView.snp.right).inset(-10)
        }
        filterButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(5)
            make.left.equalTo(jobPositionView.snp.right).inset(-10)
            make.height.equalTo(filterButton.frame.height)
            make.width.equalTo(filterButton.frame.width)
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
