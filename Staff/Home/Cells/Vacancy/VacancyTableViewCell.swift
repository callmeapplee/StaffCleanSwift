//
//  VacancyTableViewCell.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 08/10/23.
//

import UIKit
import SnapKit
import SDWebImage
protocol VacancyCellViewModel {
    var name:String {get}
    var rating:String {get}
    var companyLogoUrl:String {get}
    var companyName:String {get}
    var salary:String {get}
    var schedule:String {get}
    var city:String {get}
}
class VacancyTableViewCell: UITableViewCell {
    static let id = "VacancyTableViewCell"
    private var parentView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 105)))
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.StaffColors.vacancyBackground
        return view
    }()
    private var companyLogo:UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 80, height: 80)))
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .orange
        return imageView
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Python developer"
        return label
    }()
    private var companyName:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Alif-Academy"
        return label
    }()
    private var ratingHStackView:UIStackView = {
        let label = UILabel()
        label.text = "4.5"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        let imageView = UIImageView(image: UIImage(named: "star"))
        imageView.contentMode = .scaleAspectFit
        
        let stackView = StackViewWithLabelImage()
        stackView.label = label
        stackView.image = imageView
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    private var cityHStackView:StackViewWithLabelImage = {
        let label = UILabel()
        label.text = "Dushanbe"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        let imageView = UIImageView(image: UIImage(named: "location_gray"))
        imageView.contentMode = .scaleAspectFit
        
        let stackView = StackViewWithLabelImage()
        stackView.label = label
        stackView.image = imageView
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    private var scheduleLabel:UILabel = {
        let label = UILabel()
        label.text = "Удаленная работа"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private var scheduleHStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2.5
        return stackView
    }()
    private var salaryLabel:UILabel = {
        let label = UILabel()
        label.text = "2000-2500"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private var salaryHStackView:UIStackView = {
        let stackView = StackViewWithLabelImage()
        stackView.axis = .horizontal
        stackView.spacing = 2.5
        return stackView
    }()
    private var contentMiddleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private var contentBottomHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    private func setupSalaryHStack() {
        let imageView = UIImageView(image: UIImage(named: "money"))
        imageView.contentMode = .scaleAspectFit
        salaryHStackView.addArrangedSubview(imageView)
        salaryHStackView.addArrangedSubview(salaryLabel)
    }
    private func setupScheduleHStack() {
        let imageView = UIImageView(image: UIImage(named: "schedule"))
        imageView.contentMode = .scaleAspectFit
        scheduleHStackView.addArrangedSubview(imageView)
        scheduleHStackView.addArrangedSubview(scheduleLabel)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupScheduleHStack()
        setupSalaryHStack()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(viewModel:VacancyCellViewModel) {
        nameLabel.text = viewModel.name
        companyLogo.sd_setImage(with: URL(string: APIRouter.baseURLForImageString + viewModel.companyLogoUrl))
        companyName.text = viewModel.companyName
        salaryLabel.text = viewModel.salary
        scheduleLabel.text = viewModel.schedule
    }
    private func makeConstraints() {
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayer()
    }
    private func overlayFirstLayer() {
        contentView.addSubview(parentView)
        parentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(14)
            make.right.left.equalToSuperview().inset(16)
        }
    }
    private func overlaySecondLayer(){
        parentView.addSubview(companyLogo)
        parentView.addSubview(nameLabel)
        parentView.addSubview(contentMiddleHStackView)
        parentView.addSubview(contentBottomHStackView)
        companyLogo.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
            make.height.equalTo(companyLogo.frame.height)
            make.width.equalTo(companyLogo.frame.width)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(companyLogo.snp.top).inset(4)
            make.left.equalTo(companyLogo.snp.right).inset(-10)
            make.right.equalTo(10)
        }
        contentMiddleHStackView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).inset(-12)
            make.right.lessThanOrEqualToSuperview().inset(30)
        }
        contentBottomHStackView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.right.lessThanOrEqualToSuperview().inset(30)
            make.top.equalTo(contentMiddleHStackView.snp.bottom).inset(-8)
        }
        
    }
    private func overlayThirdLayer() {
        contentMiddleHStackView.addArrangedSubview(companyName)
        contentMiddleHStackView.addArrangedSubview(ratingHStackView)
        contentMiddleHStackView.addArrangedSubview(cityHStackView)
        
        contentBottomHStackView.addArrangedSubview(salaryHStackView)
        contentBottomHStackView.addArrangedSubview(scheduleHStackView)
        
    }
}
