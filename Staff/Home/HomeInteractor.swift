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
            service.getActiveVacancies { (activeVacancies) in
                self.presenter?.presentData(response: .presentVacancies(activeVacancies: activeVacancies))
            }
        case .getNextBatch:
            service.getNextBatch { (activeVacancies) in
                self.presenter?.presentData(response: .presentVacancies(activeVacancies: activeVacancies))
            }
        }
    }
    
    
}
