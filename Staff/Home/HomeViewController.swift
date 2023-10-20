//
//  HomeViewController.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import UIKit
import SnapKit
protocol HomeDisplayLogic:AnyObject {
  func displayData(viewModel: Home.Model.ViewModel.ViewModelData)
}
enum HomeTableViewSections:CaseIterable  {
    case search
    case topCategories
    case topCompanies
    case activeVacancies
}
class HomeViewController: UIViewController,HomeDisplayLogic{
    private var homeViewModel:HomeViewModel = HomeViewModel(topCompanies: [],
                                                            topCategories: [], categories: [],cities: [])
    private var vacanciesViewModel:VacanciesViewModel = VacanciesViewModel( vacancies: [])
    var interactor: NewsfeedBusinessLogic?
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(nil, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    private lazy var footerView = FooterView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
        interactor?.makeRequest(request: .getHome)
        interactor?.makeRequest(request: .getVacancies)
        // Do any additional setup after loading the view.
    }
    private func configureTableView() {
        tableView.addSubview(refreshControl)
        setupTableViewHeader()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        tableView.register(TopCategoriesTableViewCell.self, forCellReuseIdentifier: TopCategoriesTableViewCell.id)
        tableView.register(TopCompaniesTableViewCell.self, forCellReuseIdentifier: TopCompaniesTableViewCell.id)
        tableView.register(VacancyTableViewCell.self, forCellReuseIdentifier: VacancyTableViewCell.id)
        tableView.tableFooterView = footerView
    }
    private func setupTableViewHeader() {
        let tableHeaderView = HomeHeaderView(frame: CGRect(origin: .zero,
                                                       size: CGSize(width: self.view.frame.width, height: 70)))
        tableView.tableHeaderView = tableHeaderView
    }
    private func setup() {
        let viewController        = self
        let interactor            = HomeInteractor()
        let presenter             = HomePresenter()
        //let router                = HomeRouter()
        viewController.interactor = interactor
        //viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
      //  router.viewController     = viewController
    }
    @objc private func refresh() {
        interactor?.makeRequest(request: Home.Model.Request.RequestType.getHome)
        interactor?.makeRequest(request: Home.Model.Request.RequestType.getVacancies)
    }
    func displayData(viewModel: Home.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayHome(let homeViewModel):
            self.homeViewModel = homeViewModel
            tableView.reloadData()
            refreshControl.endRefreshing()
        case .displayVacancies(vacancies: let vacancies):
            self.vacanciesViewModel = vacancies
            tableView.reloadData()
        case .displayFooterLoader:
            footerView.showLoader()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController:UITableViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height + 30 {
            interactor?.makeRequest(request: Home.Model.Request.RequestType.getNextBatch)
        }
    }
}
extension HomeViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeTableViewSections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeTableViewSections.allCases[section] {
        case .search:
            return 1
        case .topCategories,.topCompanies:
            return 1
        case .activeVacancies:
            return vacanciesViewModel.vacancies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section, row = indexPath.row
        switch HomeTableViewSections.allCases[section] {
        case .search:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
            cell.setup(categories: homeViewModel.categories, cities: homeViewModel.cities)
            cell.filterView.delegate = self
            cell.searchBar.delegate = self
            return cell
        case .topCategories:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCategoriesTableViewCell.id, for: indexPath) as! TopCategoriesTableViewCell
            cell.setup(topCategories: homeViewModel.topCategories)
            return cell
        case .topCompanies:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCompaniesTableViewCell.id, for: indexPath) as! TopCompaniesTableViewCell
            cell.setup(topCompanies: homeViewModel.topCompanies)
            return cell
        case .activeVacancies:
            let cell = tableView.dequeueReusableCell(withIdentifier: VacancyTableViewCell.id, for: indexPath) as! VacancyTableViewCell
            cell.setup(viewModel: vacanciesViewModel.vacancies[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeTableViewSections.allCases[section] {
        case .search:
            return nil
        case .topCategories:
            let view = UIView()
            
            let titleLabel = UILabel()
            titleLabel.text = "Топ категории".localized()
            titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
            
            let allCategoriesButton = UIButton(type: .system)
            allCategoriesButton.setTitle("Все категории".localized(), for: .normal)
            allCategoriesButton.titleLabel?.font = .systemFont(ofSize: 14)
            
            let contentHStackView = UIStackView(arrangedSubviews: [titleLabel,allCategoriesButton])
            view.addSubview(contentHStackView)
            contentHStackView.alignment = .center
            contentHStackView.distribution = .equalCentering
            contentHStackView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(13)
                make.top.greaterThanOrEqualToSuperview()
            }
            return view
        case .topCompanies:
            let view = UIView()
            
            let titleLabel = UILabel()
            titleLabel.text = "Топ компании".localized()
            titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
            
            let allCategoriesButton = UIButton(type: .system)
            allCategoriesButton.setTitle("Все компании".localized(), for: .normal)
            allCategoriesButton.titleLabel?.font = .systemFont(ofSize: 14)
            
            let contentHStackView = UIStackView(arrangedSubviews: [titleLabel,allCategoriesButton])
            view.addSubview(contentHStackView)
            contentHStackView.alignment = .center
            contentHStackView.distribution = .equalCentering
            contentHStackView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(13)
                make.top.greaterThanOrEqualToSuperview()
            }
            return view
        case .activeVacancies:
            let view = UIView()
            
            let titleLabel = UILabel()
            titleLabel.text = "Актуальные вакансии".localized()
            titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
            
            view.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(19)
                make.top.greaterThanOrEqualToSuperview()
            }
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch HomeTableViewSections.allCases[section] {
        case .search:
            return 20
        case .topCategories:
            return 65
        case .topCompanies:
            return 65
        case .activeVacancies:
            return 65
        }
    }
    
}
extension HomeViewController:FilterViewDelegate,UISearchBarDelegate {
    func filterDidChange(cityId: Int?, categoryId: Int?) {
        interactor?.makeRequest(request: .setParams(params: ["city_id": cityId, "category_id":categoryId]))
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: DispatchWorkItem(block: {
            self.interactor?.makeRequest(request: .setParams(params: ["title":searchText]))
        }))
    }
}
