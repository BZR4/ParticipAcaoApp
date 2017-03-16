//
//  Feed.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/14/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class Feed {
    
    var userPost: User?
    var categoryPost: Categories?
    var datePost: NSDate?
    var imgPost: NSData?
    var titlePost: String?
    var objectID: String?
    
    init() {
        userPost = User()
        categoryPost = Categories()
        datePost = NSDate()
        imgPost = nil
        titlePost = ""
        objectID = ""
    }
    
    convenience init (userName: String, userImg: NSData, imgCategory: String, titleCategory: String, categoryDescription:String, datePost: NSDate, titlePost: String, objectID: String) {
        self.init()
        self.userPost = User(userName: userName, userImg: userImg)
        self.categoryPost = Categories(imgCategory: imgCategory, titleCategory: titleCategory, categoryDescription: categoryDescription)
        self.datePost = datePost
        self.imgPost = nil
        self.titlePost = titlePost
        self.objectID = objectID
    }
    
    convenience init (userName: String, userImg: NSData, imgCategory: String, titleCategory: String, categoryDescription:String, datePost: NSDate, imgPost: NSData, titlePost: String, objectID: String) {
        self.init()
        self.userPost = User(userName: userName, userImg: userImg)
        self.categoryPost = Categories(imgCategory: imgCategory, titleCategory: titleCategory, categoryDescription: categoryDescription)
        self.datePost = datePost
        self.imgPost = imgPost
        self.titlePost = titlePost
        self.objectID = objectID
    }
}
