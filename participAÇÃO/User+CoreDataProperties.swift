//
//  User+CoreDataProperties.swift
//  participAÇÃO
//
//  Created by Esdras Bezerra da Silva on 16/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User_ {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var userName: String?
    @NSManaged var email: String?
    @NSManaged var password: String?
    @NSManaged var neighborhood: Neighborhood?
    @NSManaged var topic: NSSet?
    @NSManaged var reply: NSSet?

}
