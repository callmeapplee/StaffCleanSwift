//
//  HomeService.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
class HomeService {
    var fetcher:DataFetcher = NetworkDataFetcher()
    private var currentPage:Int = 1
    private var vacanciesResponse:VacanciesResponse?
    private var filterParams:[String:Any] = [:]
    private var isFetchingMore = true
    private var isVacanciesFiltered:Bool {
        return !filterParams.isEmpty
    }
    func setFilterParams(params:[String:Any?]) {
        params.forEach { (paramsKey,paramsValue) in
            guard let value = paramsValue else {
                self.filterParams.removeValue(forKey: paramsKey)
                return
            }
            self.filterParams[paramsKey] = value
        }
    }
    
    func getHome(completion : @escaping(HomeResponse)->Void) {
        fetcher.getHome { (HomeResponse) in
            guard let home = HomeResponse else { return }
            completion(home)
        }
    }
    private func getActiveVacancies(completion: @escaping(VacanciesResponse?)->Void) {
        fetcher.getActiveVacancies(page: currentPage) {  (activeVacanciesResponse) in
            completion(activeVacanciesResponse)
        }
    }
    private func getFilteredVacancies(completion: @escaping(VacanciesResponse?)->Void) {
        fetcher.getFilteredVacancies(page: currentPage,params: filterParams) {  (filteredVacanciesResponse) in
            completion(filteredVacanciesResponse)
        }
    }
    func getVacancies( completion: @escaping(VacanciesResponse)->Void) {
        currentPage = 1
        let isFiltered = self.isVacanciesFiltered
        if isFiltered {
            getFilteredVacancies { filteredVacanciesResponse in
                guard let vacanciesResponse = filteredVacanciesResponse else {
                    return
                }
                self.isFetchingMore = vacanciesResponse.data.isEmpty
                self.vacanciesResponse = vacanciesResponse
                completion(vacanciesResponse)
            }
        }else{
            getActiveVacancies { activeVacanciesResponse in
                guard let vacanciesResponse = activeVacanciesResponse else {
                    return
                }
                self.isFetchingMore = vacanciesResponse.data.isEmpty
                self.vacanciesResponse = vacanciesResponse
                completion(vacanciesResponse)
            }
        }
    }
    func getNextBatch(completion: @escaping (VacanciesResponse) -> Void) {
        let isFiltered = self.isVacanciesFiltered
        print("current page",currentPage)
        if !isFetchingMore {
            isFetchingMore = true
            currentPage += 1
            if isFiltered {
                getFilteredVacancies { filteredVacanciesResponse in
                    guard let vacanciesResponse = filteredVacanciesResponse else {
                        return
                    }
                    self.vacanciesResponse?.data.append(contentsOf: vacanciesResponse.data)
                    self.isFetchingMore = vacanciesResponse.data.isEmpty
                    guard let vacancyResponseToSend = self.vacanciesResponse else {
                        return
                    }
                    completion(vacancyResponseToSend)
                }
            }else{
                getActiveVacancies { activeVacanciesResponse in
                    guard let vacanciesResponse = activeVacanciesResponse else {
                        return
                    }
                    self.vacanciesResponse?.data.append(contentsOf: vacanciesResponse.data)
                    self.isFetchingMore = vacanciesResponse.data.isEmpty
                    guard let vacancyResponseToSend = self.vacanciesResponse else {
                        return
                    }
                    completion(vacancyResponseToSend)
                }
            }
        }
        
    }
}
