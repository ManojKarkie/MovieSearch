//
//  RecentSearch+CoreDataProperties.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/31/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//
//

import UIKit
import CoreData

extension RecentSearch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearch> {
        return NSFetchRequest<RecentSearch>(entityName: "RecentSearch")
    }

    @NSManaged public var searchText: String?
    @NSManaged public var searchDate: NSDate?

}

// MARK:- Model Logic

extension RecentSearch {

    public class func saveRecent(text: String?) {

        if let entity = NSEntityDescription.entity(forEntityName: "RecentSearch", in: AppUtility.appDelegate.managedObjectContext) {
            let recentSearch = RecentSearch.init(entity: entity, insertInto: AppUtility.appDelegate.managedObjectContext)
            recentSearch.searchText = text
            recentSearch.searchDate = NSDate()
            do {
                try AppUtility.appDelegate.managedObjectContext.save()
            }catch let exception {
                print("Error when saving recent search \(exception.localizedDescription)")
            }

        }

    }

    // MARK:- Return Top 10 Searches

    public class var topSearches: [RecentSearch] {

        let fetchRequest = NSFetchRequest<RecentSearch>(entityName: "RecentSearch")
        let sortDescriptor = NSSortDescriptor.init(key: "searchDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
             let results = try AppUtility.appDelegate.managedObjectContext.fetch(fetchRequest)
           // let results: [RecentSearch] = Array(fetchResults.reversed())

            if results.count > 10 {
                results.forEach { recentItem in
                    let index = results.index(of: recentItem) ?? 0
                    if index > 9 {
                        AppUtility.appDelegate.managedObjectContext.delete(recentItem)
                    }
                }
            }

            let filteredResults = results.filter { recentItem in
                let index = results.index(of: recentItem) ?? 0
                return index <= 9
            }
            return filteredResults
        }catch let exception {
            print("Error in fetching top recent searches \(exception)")

        }
        return []
    }

}
