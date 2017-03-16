//
//  FormatDate.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/14/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class FormatDate {
    
    static func createDateFormatter (date: NSDate) -> (date: String, hour: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let newDate = dateFormatter.stringFromDate(date)
        
        let hourFormatter = NSDateFormatter()
        hourFormatter.dateFormat = "HH:mm"
        let newHour = hourFormatter.stringFromDate(date)
        
        return (newDate, newHour)
    }
}