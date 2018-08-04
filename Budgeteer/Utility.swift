//
//  Utility.swift
//  Budgeteer
//
//  Created by Brendon Warwick on 04/08/2018.
//  Copyright © 2018 BW. All rights reserved.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
