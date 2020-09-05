//
//  PRResponseModel.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

struct PRResponseModel: Decodable {
    var id: Int?
    var title: String?
    var created_at: String?
    var closed_at: String?
    var merged_at: String?
    var user: User?
}

struct User: Decodable {
    var login: String?
}
