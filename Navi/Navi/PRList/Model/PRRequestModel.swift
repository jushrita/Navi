//
//  PRRequestModel.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

enum PRState: String {
    case all, closed, open
}

struct PRRequestModel {
    var state: PRState
    var pageNumber: Int
    var pageSize: Int
}
