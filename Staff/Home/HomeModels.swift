//
//  HomeModels.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 05/10/23.
//

import Foundation
enum Home {
   
  enum Model {
    struct Request {
      enum RequestType {
          case getHome
          case getVacancies
          case getNextBatch
      }
    }
    struct Response {
      enum ResponseType {
          case presentHome(home:HomeResponse)
          case presentVacancies(activeVacancies:VacanciesResponse)
          case presentFooterLoader
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayHome(homeViewModel: HomeViewModel)
          case displayVacancies(activeVacancies: VacanciesViewModel)
          case displayFooterLoader
      }
    }
  }
}

//struct UserViewModel: TitleViewViewModel {
//    var photoUrlString: String?
//}
//
struct HomeViewModel {
    struct TopCategoryCell:TopCategoryCellViewModel {
        var categoryIconUrl: String
        var categoryName: String
    }
    struct TopCompanyCell: TopCompanyCellViewModel {
        var companyLogoUrl: String
    }
    
    let topCompanies: [TopCompanyCell]
    let topCategories: [TopCategoryCell]
}
struct VacanciesViewModel {
    struct VacancyCell:VacancyCellViewModel {
        var name: String
        
        var rating: String
        
        var companyLogoUrl: String
        
        var companyName: String
        
        var salary: String
        
        var schedule: String
        
        var city: String
        
    }
    var activeVacancies: [VacancyCell]
    
}
