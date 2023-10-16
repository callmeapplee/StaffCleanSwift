//
//  NetworkService.swift
//  Staff
//
//  Created by Ботурбек Имомдодов on 15/10/23.
//

import Foundation
import Alamofire
final class NetworkService:Alamofire.RequestInterceptor,RequestAdapter {
    private init(){ }
    static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        
        return Session(configuration: configuration, interceptor: NetworkService())
    }()
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    
}
