//
//  PRListNetworkService.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation
import Alamofire

typealias PRListResponse = (response: [PRResponseModel]?, error: BaseError?)

class PRListNetworkService {
    var  requestParams: PRRequestModel
    init(requestParams: PRRequestModel) {
        self.requestParams = requestParams
    }
    
    func getPRList(completionHandler: @escaping (PRListResponse) -> ()) {
        let params = ["state": requestParams.state.rawValue]
        AF.request(prURL, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else {
                completionHandler((response: nil, error: .generic))
                return
            }
            do {
                let prData = try JSONDecoder().decode([PRResponseModel].self, from: data)
                completionHandler((response: prData, error: nil))
            } catch {
                completionHandler((response: nil, error: .jsonParsingError))
            }
        }
    }
}
