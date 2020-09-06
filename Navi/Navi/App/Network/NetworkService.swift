//
//  NetworkService.swift
//  Navi
//
//  Created by Jushrita on 06/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    var httpMethod: HTTPMethod = .get
    func makeAPICall(url:String, prams: [String: Any]?, completionHandler: @escaping ((AFDataResponse<Any>) -> Void)) {
        AF.request(url, method: httpMethod, parameters: prams).responseJSON  { response in
            completionHandler(response)
        }
    }
    
    func getData(url:String) {
        
    }
}
