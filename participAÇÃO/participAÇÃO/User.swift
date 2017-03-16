//
//  User.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/14/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation

class User {
    
    // User Features
    var userName: String?
    var userImg: NSData?//String?
    
    init () {
        userName = ""
        userImg = nil
    }
    
    convenience init (userName: String, userImg: NSData) {
        self.init()
        self.userName = userName
        self.userImg = userImg
    }
    
}
