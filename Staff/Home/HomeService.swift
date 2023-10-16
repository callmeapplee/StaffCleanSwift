//
//  HomeService.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
class HomeService {
    var fetcher:DataFetcher = NetworkDataFetcher()
    var currentPage:Int = 1
    var activeVacanciesResponse:VacanciesResponse?
    func getHome(completion : @escaping(HomeResponse)->Void) {
        fetcher.getHome { (HomeResponse) in
            guard let home = HomeResponse else { return }
            completion(home)
        }
    }
    func getActiveVacancies( completion: @escaping(VacanciesResponse)->Void) {
        currentPage = 1
        fetcher.getActiveVacancies(page: currentPage) {  (activeVacanciesResponse) in
            guard let vacanciesResponse = activeVacanciesResponse else {
                return
            }
            self.activeVacanciesResponse = vacanciesResponse
            completion(vacanciesResponse)
        }
    }
    func getNextBatch(completion: @escaping (VacanciesResponse) -> Void) {
        if currentPage == activeVacanciesResponse?.currentPage {
            currentPage += 1
            print(currentPage)
            fetcher.getActiveVacancies(page: currentPage) { activeVacanciesResponse in
                guard let vacanciesResponse = activeVacanciesResponse, vacanciesResponse.data.count > 0 else {
                    return
                }
                self.activeVacanciesResponse?.data.append(contentsOf: vacanciesResponse.data)
            }
        }
        guard let vacanciesResponse = self.activeVacanciesResponse else { return }
        completion(vacanciesResponse)
    }
}
