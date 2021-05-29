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
    
    func getPastSevenDays() -> [String] {
        let calendar = Calendar.current
        var date = calendar.startOfDay(for: Date())
        var days = [String]()
        
        for _ in 1...7 {
            let day = format(date: date)
            days.append(day)
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return days
    }
    
    func getPastSevenDaysLabel() -> [String] {
        let tempFormater = DateFormatter()
        tempFormater.dateFormat = "MM/dd"
        
        let calendar = Calendar.current
        var date = calendar.startOfDay(for: Date())
        var days = [String]()
        
        for _ in 1...7 {
            print("day: \(date)")
            let day = tempFormater.string(from: date)
            days.append(day)
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return days
    }
}
