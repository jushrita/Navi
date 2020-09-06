//
//  AvatarNetworkService.swift
//  Navi
//
//  Created by Jushrita on 06/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

typealias AvatarResponse = (response: Data?, error: BaseError?)

class AvatarNetworkService {
    var  url: String
    init(url: String) {
        self.url = url
    }
    
    func getAvatar(completionHandler: @escaping (AvatarResponse) -> ()) {
        DispatchQueue.global().async {
            NetworkService().makeAPICall(url: self.url, prams: nil, completionHandler: { response in
                guard let data = response.data else {
                    completionHandler((response: nil, error: .generic))
                    return
                }
                completionHandler((response: data, error: nil))
            })
        }
    }
}
