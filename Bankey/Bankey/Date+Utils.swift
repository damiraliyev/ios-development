//
//  Date+Utils.swift
//  Bankey
//
//  Created by Damir Aliyev on 12.08.2022.
//

import Foundation

extension Date{
    static var bankeyDateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    var monthDayYearString: String{
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
