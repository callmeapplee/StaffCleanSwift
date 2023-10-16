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
}
class NetworkDataFetcher:DataFetcher {
    func getActiveVacancies(page: Int, response completion: @escaping (VacanciesResponse?) -> Void) {
        NetworkService.sessionManager.request(APIRouter.activeVacancies(page: page)).responseDecodable(of:VacanciesResponseWrapped.self) { response in
            print("Temptemp", String(data: response.data ?? Data(), encoding: .utf8))
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
