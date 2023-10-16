//
//  HomePresenter.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
protocol HomePresentationLogic {
  func presentData(response: Home.Model.Response.ResponseType)
}
class HomePresenter:HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    func presentData(response: Home.Model.Response.ResponseType) {
        switch response {
        case .presentHome(let home):
            let topCompanies = home.topCompanies.map { (topCompany) in
                HomeViewModel.TopCompanyCell(companyLogoUrl: topCompany.logo)
            }
            let topCategories = home.topCategories.map { (topCategory) in
                HomeViewModel.TopCategoryCell.init(categoryIconUrl: topCategory.icon, categoryName: topCategory.name)
            }
            viewController?.displayData(viewModel: .displayHome(homeViewModel:HomeViewModel.init(topCompanies: topCompanies, topCategories: topCategories) ))
        case .presentVacancies(activeVacancies: let activeVacancies):
            let vacancies = activeVacancies.data.map { vacancy in
                vacancyCellViewModel(vacancy: vacancy)
            }
            viewController?.displayData(viewModel: .displayVacancies(activeVacancies: VacanciesViewModel(activeVacancies: vacancies)))
        case .presentFooterLoader:
            viewController?.displayData(viewModel: .displayFooterLoader)
        }
    }
    private func vacancyCellViewModel(vacancy:Vacancy) -> VacanciesViewModel.VacancyCell{
       return VacanciesViewModel.VacancyCell.init(name: vacancy.position , rating: "", companyLogoUrl: vacancy.employer.logo, companyName: vacancy.employer.name, salary: "\(vacancy.salaryMin)-\(vacancy.salaryMax)", schedule: vacancy.scheduleType.name, city: vacancy.city.nameRu)
    }
    
    
    
}
