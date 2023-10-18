//
//  NetworkDataFetcher.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
protocol DataFetcher {
    func getHome(response completion: @escaping(HomeResponse?) -> Void)
    func getActiveVacancies(page:Int,response completion: @escaping(VacanciesResponse?) -> Void)
    func getFilteredVacancies(page:Int,params:[String:Any],response completion: @escaping(VacanciesResponse?) -> Void)
}
class NetworkDataFetcher:DataFetcher {
    func getFilteredVacancies(page: Int, params:[String:Any], response completion: @escaping (VacanciesResponse?) -> Void) {
        NetworkService.sessionManager.request(APIRouter.filteredVacancies(page: page, filterParams: params)).responseDecodable(of:VacanciesResponseWrapped.self) { response in
            print("LOGGGG",String(data: response.data ?? Data(), encoding: .utf8))
            switch response.result {
            case .success(let data):
                completion(data.response)
            case .failure(let error):
                print("Filtered vacancies error ",error)
            }
        }
    }
    
    func getActiveVacancies(page: Int, response completion: @escaping (VacanciesResponse?) -> Void) {
        NetworkService.sessionManager.request(APIRouter.activeVacancies(page: page)).responseDecodable(of:VacanciesResponseWrapped.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.response)
            case .failure(let error):
                print("Active vacancies error ",error)
            }
        }
    }
    
    func getHome(response completion: @escaping (HomeResponse?) -> Void) {
        NetworkService.sessionManager.request(APIRouter.home).responseDecodable(of:HomeResponseWrapped.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.response)
            case .failure(let error):
                print("Home error ",error)
            }
        }
    }
    
    
    
    
}
