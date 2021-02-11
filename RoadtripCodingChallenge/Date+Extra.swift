//
//  Date+Extra.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import Foundation

extension Date {
    
    init(date: NSDate) {
        self.init(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate)
    }
    
    func currentUTCDateAndTimeString() -> String {
        let date = Date()
        let calendar = Calendar.current
        _ = calendar.component(.hour, from: date)
        _ = calendar.component(.minute, from: date)
        return "Hello"
    }
}
