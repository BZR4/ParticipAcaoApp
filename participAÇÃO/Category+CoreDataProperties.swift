//
//  Category+CoreDataProperties.swift
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

extension Category {

    @NSManaged var category: String?
    @NSManaged var categoryDescription: String?
    @NSManaged var topic: NSSet?

}
