//
//  DateUtility.swift
//  Navi
//
//  Created by Jushrita on 06/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

class DateUtility {
    static func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = utcDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = creationDateFormat
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
