//
//  Day.swift
//  Budgeteer
//
//  Created by Brendon Warwick on 03/08/2018.
//  Copyright © 2018 BW. All rights reserved.
//

import Foundation

/// The object used to store dates in a simple, equatable way
class BWDate {
    var day: Int!
    var month: Int!
    var year: Int!
    
    // The storage keys for persisting a BWDate
    let lastDayKey = "BWLastOpenedDay"
    let lastMonthKey = "BWLastOpenedMonth"
    let lastYearKey = "BWLastOpenedYear"
    
    init() {
        self.day = 1
        self.month = 1
        self.year = 1970
    }
    
    init(_ day: Int, _ month: Int, _ year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    static func == (lhs: BWDate, rhs: BWDate) -> Bool {
        return rhs.day == lhs.day &&
               rhs.month == lhs.month &&
               rhs.year == lhs.year
    }
    
    func saveToDisk() {
        UserDefaults.standard.set(self.day, forKey: lastDayKey)
        UserDefaults.standard.set(self.month, forKey: lastMonthKey)
        UserDefaults.standard.set(self.year, forKey: lastYearKey)
    }
    
    func loadLatestFromDisk() -> BWDate {
        // If no date is found, return 1/1/1970
        let day = UserDefaults.standard.object(forKey: lastDayKey) as? Int
        let month = UserDefaults.standard.object(forKey: lastMonthKey) as? Int
        let year = UserDefaults.standard.object(forKey: lastYearKey) as? Int 
        
        return BWDate(day ?? 1, month ?? 1, year ?? 1970)
    }
    
    func string() -> String {
        return "\(String(describing: self.day!))-\(String(describing: self.month!))-\(String(describing: self.year!))"
    }
}


