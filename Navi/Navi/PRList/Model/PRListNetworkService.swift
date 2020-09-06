//
//  PRListNetworkService.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

typealias PRListResponse = (response: [PRResponseModel]?, error: BaseError?)

class PRListNetworkService {
    var  requestParams: PRRequestModel
    init(requestParams: PRRequestModel) {
        self.requestParams = requestParams
    }
    
    func getPRList(completionHandler: @escaping (PRListResponse) -> ()) {
        NetworkService().makeAPICall(url: prURL, prams: getParams(), completionHandler: { response in
            guard let data = response.data else {
                completionHandler((response: nil, error: .generic))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let prData = try decoder.decode([PRResponseModel].self, from: data)
                completionHandler((response: prData, error: nil))
            } catch {
                completionHandler((response: nil, error: .jsonParsingError))
            }
        })
    }
    
    func getParams() -> [String: Any] {
        var params = [String: Any]()
        params["state"] = requestParams.state.rawValue
        params["page"] = requestParams.pageNumber
        params["per_page"] = requestParams.pageSize
        return params
    }
}
