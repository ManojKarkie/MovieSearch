//
//  RecentSearch+CoreDataProperties.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/31/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//
//

import Foundation
import CoreData


extension RecentSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearch> {
        return NSFetchRequest<RecentSearch>(entityName: "RecentSearch")
    }

    @NSManaged public var searchText: String?
    @NSManaged public var searchDate: NSDate?

}
