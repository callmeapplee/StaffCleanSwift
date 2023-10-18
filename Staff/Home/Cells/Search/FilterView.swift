//
//  FilterView.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit
protocol FilterPickerRowViewModel {
    var name:String {get}
}
protocol FilterViewDelegate {
    func filterDidChange(cityId:Int?,categoryId:Int?)
}
class FilterView: UIView {
    private let defaultIndex = 0
    private var cityPicker = UIPickerView()
    private var categoryPicker = UIPickerView()
    private var categories:[HomeViewModel.FilterPickerRow] = []
    private var cities:[HomeViewModel.FilterPickerRow] = []
    var delegate:FilterViewDelegate?
    private var cityTextField:UITextField = {
        let textField = UITextField()
        textField.tintColor = .clear
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Города".localized()
        let cityPicker = UIPickerView()
        
        return textField
    }()
    private var cityView:UIView = {
        let cityView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 110, height: 33)))
        cityView.backgroundColor = .white
        cityView.layer.cornerRadius = 8
        return cityView
    }()
    private var categoryTextField:UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.tintColor = .clear
        textField.placeholder = "Вакансии".localized()
        textField.textAlignment = .justified
        return textField
    }()
    private var categoryView:UIView = {
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
    private func setupPickers() {
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryTextField.inputView = categoryPicker
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityTextField.inputView = cityPicker
    }
    func setupToolBar(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Выбрать".localized(), style: UIBarButtonItem.Style.done, target: self, action: #selector(toolBarDoneButtonTapped))
        doneButton.tintColor = .blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена".localized(), style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeInputViews))
        cancelButton.tintColor = .red
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        cityTextField.inputAccessoryView = toolBar
        categoryTextField.inputAccessoryView = toolBar
    }
    func setup(categories:[HomeViewModel.FilterPickerRow], cities:[HomeViewModel.FilterPickerRow]) {
        self.categories = categories
        self.cities = cities
        categoryPicker.reloadAllComponents()
        cityPicker.reloadAllComponents()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.StaffColors.primary
        setupToolBar()
        setupPickers()
        makeConstraints()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupCategoryView() {
        let rightIcon = UIImageView(image: UIImage(named: "arrow_down"))
        rightIcon.contentMode = .scaleAspectFill
        categoryView.addSubview(categoryTextField)
        categoryView.addSubview(rightIcon)
        categoryTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(7)
        }
        rightIcon.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTextField.snp.centerY)
            make.right.equalToSuperview().inset(7)
            make.left.equalTo(categoryTextField.snp.right).inset(-5)
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
        setupCategoryView()
        addSubview(cityView)
        addSubview(categoryView)
        addSubview(filterButton)
        cityView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(cityView.frame.width)
        }
        categoryView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalTo(cityView.snp.right).inset(-10)
        }
        filterButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(5)
            make.left.equalTo(categoryView.snp.right).inset(-10)
            make.height.equalTo(filterButton.frame.height)
            make.width.equalTo(filterButton.frame.width)
        }
    }
    @objc func closeInputViews() {
        cityTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
    }
    
    @objc func toolBarDoneButtonTapped() {
        let citySelectedIndex = cityPicker.selectedRow(inComponent: 0)
        let categorySelectedIndex = categoryPicker.selectedRow(inComponent: 0)
        categoryTextField.text = nil
        cityTextField.text = nil
        if citySelectedIndex != defaultIndex {
            cityTextField.text = cities[citySelectedIndex].name
        }
        if categorySelectedIndex != defaultIndex {
            categoryTextField.text = categories[categorySelectedIndex].name
        }
        cityTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        delegate?.filterDidChange(cityId: cities[citySelectedIndex].id, categoryId: categories[categorySelectedIndex].id)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
extension FilterView:UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categoryPicker:
            return categories.count
        case cityPicker:
            return cities.count
        default:
            return 10
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPicker:
            return categories[row].name
        case cityPicker:
            return cities[row].name
        default:
            return "Fail"
        }
    }
}
