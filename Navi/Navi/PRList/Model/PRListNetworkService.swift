//
//  PRListNetworkService.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation
import Alamofire

typealias PRListResponse = (response: PRResponseModel?, error: Error?)

class PRListNetworkService {
    var  requestParams: PRRequestModel
    init(requestParams: PRRequestModel) {
        self.requestParams = requestParams
    }
    
    func getPRList(completionHandler:(PRListResponse) -> ()) {
        let params = ["status": requestParams.state.rawValue]
        AF.request(URL.prURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response)
        }
    }
}
