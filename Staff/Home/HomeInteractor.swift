//
//  HomeInteractor.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
protocol NewsfeedBusinessLogic {
  func makeRequest(request: Home.Model.Request.RequestType)
}
class HomeInteractor:NewsfeedBusinessLogic {
    var presenter: HomePresentationLogic?
    var service = HomeService()
    func makeRequest(request: Home.Model.Request.RequestType) {
        switch request {
        case .getHome:
            service.getHome {  (home) in
                self.presenter?.presentData(response: .presentHome(home: home))
            }
        case .getVacancies:
            self.presenter?.presentData(response: .presentFooterLoader)
            service.getVacancies { (vacancies, isVacanciesFiltered)  in
                self.presenter?.presentData(response: .presentVacancies(vacancies: vacancies, isFiltered: isVacanciesFiltered))
            }
        case .getNextBatch:
            service.getNextBatch { (vacancies,isVacanciesFiltered)  in
                self.presenter?.presentData(response: .presentVacancies(vacancies: vacancies, isFiltered: isVacanciesFiltered))
            }
        case .setParams(params: let params):
            self.presenter?.presentData(response: .presentFooterLoader)
            service.setParams(params: params)
            service.getVacancies { (vacancies, isVacanciesFiltered) in
                self.presenter?.presentData(response: .presentVacancies(vacancies: vacancies, isFiltered: isVacanciesFiltered))
            }
        }
    }
    
    
}
