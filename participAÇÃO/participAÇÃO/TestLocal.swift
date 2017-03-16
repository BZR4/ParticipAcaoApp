//
//  TestLocal.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/19/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class TestLocal {
    
    static func saveTestArray (array: [String]) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(array, forKey: "saveStrings")
    }
    
    static func getTestArray () -> [String] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var array: [String] = []
        if let arraySaved: [String] = userDefaults.objectForKey("saveStrings") as? [String] {
            array = arraySaved
        }
        
        return array
    }
}