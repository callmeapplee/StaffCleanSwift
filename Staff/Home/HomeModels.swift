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
          case setParams(params:[String:Any?])
      }
    }
    struct Response {
      enum ResponseType {
          case presentHome(home:HomeResponse)
          case presentVacancies(vacancies:VacanciesResponse, isFiltered:Bool)
          case presentFooterLoader
      }
    }
    struct ViewModel {
      enum ViewModelData {
          case displayHome(homeViewModel: HomeViewModel)
          case displayVacancies(vacancies: VacanciesViewModel)
          case displayFooterLoader
      }
    }
  }
}
struct HomeViewModel {
    struct FilterPickerRow:FilterPickerRowViewModel {
        var name: String
        var id: Int?
    }
    struct TopCategoryCell:TopCategoryCellViewModel {
        var categoryIconUrl: String
        var categoryName: String
    }
    struct TopCompanyCell: TopCompanyCellViewModel {
        var companyLogoUrl: String
    }
    let topCompanies: [TopCompanyCell]
    let topCategories: [TopCategoryCell]
    let categories: [FilterPickerRow]
    let cities: [FilterPickerRow]
}
struct VacanciesViewModel {
    var isVacanciesFiltered:Bool
    struct VacancyCell:VacancyCellViewModel {
        var name: String
        
        var rating: String
        
        var companyLogoUrl: String
        
        var companyName: String
        
        var salary: String
        
        var schedule: String
        
        var city: String
        
    }
    var vacancies: [VacancyCell]
    
}
