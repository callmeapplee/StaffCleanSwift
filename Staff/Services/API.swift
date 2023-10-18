//
//  API.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
import Alamofire
enum APIRouter:URLRequestConvertible {
    static let baseURLForImageString = "http://194.26.138.61"
    static let baseURLString = "http://194.26.138.61/api/"
    case home
    case activeVacancies(page:Int)
    case filteredVacancies(page:Int,filterParams:[String:Any])
    var method:HTTPMethod {
        switch self {
        case .home,.activeVacancies,.filteredVacancies:
            return .get
            
        }
    }
    var path:String {
        switch self{
        case .home:
            return "home"
        case .activeVacancies:
            return "active-vacancies"
        case .filteredVacancies:
            return "vacancies"
        }
    }
    var parameters:Parameters? {
        switch self {
        case .home:
            return [:]
        case .activeVacancies(let page):
            return ["page" : page,"per_page":15]
        case .filteredVacancies(let page, let filterParams):
            var params = filterParams
            params["page"] = page
            params["per_page"] = 15
            return params
        }
    }
    var body:Data? {
        switch self {
        case .home,.activeVacancies,.filteredVacancies:
            return nil
        }
    }
    func asURLRequest() throws -> URLRequest{
        let url = try APIRouter.baseURLString.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let dict = parameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = dictionaryToQueryParams(dict)
            urlRequest.url = urlComponents?.url
        }
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("$2y$10$ervEvrbALg5WF84KTJIuu.OU4kjDfmPkGy9TXO3pBGC5SCeS6n/mK", forHTTPHeaderField: "Access-Token")
        urlRequest.setValue("MacOS", forHTTPHeaderField: "Platform-Version")
        urlRequest.setValue("MacOS", forHTTPHeaderField: "Platform")
        urlRequest.setValue("MacOS", forHTTPHeaderField: "Device")
        
        print("URLLL",urlRequest.url)
        return urlRequest
    }
    private func dictionaryToQueryParams(_ dictionary: [String: Any]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        for (key, value) in dictionary {
            if let arrayValue = value as? [Any] {
                for element in arrayValue {
                    let arrayKey = "\(key)[]"
                    queryItems.append(URLQueryItem(name: arrayKey, value: "\(element)"))
                }
            } else {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        queryItems.append(URLQueryItem(name: "language_id", value: "3"))
        return queryItems
    }
}
