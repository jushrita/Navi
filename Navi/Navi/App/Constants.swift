//
//  Constants.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

enum BaseError: Error {
    case generic
    case jsonParsingError
}

let creationDateFormat = "h:mm a 'on' MMMM dd, yyyy"
let utcDateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
