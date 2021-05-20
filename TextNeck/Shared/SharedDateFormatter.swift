//
//  DateFormatter.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/20.
//

import UIKit

class SharedDateFormatter {
    var formatter: DateFormatter
    
    init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    func getToday() -> String {
        let today = Date()
        let todayString = formatter.string(from: today)
        return todayString
    }
    
    func format(date: Date) -> String {
        let dateString = formatter.string(from: date)
        return dateString
    }
}
