//
//  Categories.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/15/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class Categories {
    
    var imgCaterory: String?
    var titleCategory: String?
    var categoryDescription: String?
    
    init () {
        imgCaterory = ""
        titleCategory = ""
        categoryDescription = ""
    }
    
    convenience init (imgCategory: String, titleCategory: String) {
        self.init()
        self.imgCaterory = imgCategory
        self.titleCategory = titleCategory
        self.categoryDescription = ""
    }
    
    convenience init (imgCategory: String, titleCategory: String, categoryDescription: String) {
        self.init()
        self.imgCaterory = imgCategory
        self.titleCategory = titleCategory
        self.categoryDescription = categoryDescription
    }
    
}