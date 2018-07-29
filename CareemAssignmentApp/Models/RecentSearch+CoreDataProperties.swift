//
//  RecentSearch+CoreDataProperties.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
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

}

// MARK:- Model Logic

extension RecentSearch {

    public class func saveRecent(text: String?) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        if let entity = NSEntityDescription.entity(forEntityName: "RecentSearch", in: appDelegate.managedObjectContext) {
               let recentSearch = RecentSearch.init(entity: entity, insertInto: appDelegate.managedObjectContext)
               recentSearch.searchText = text
              do {
               try appDelegate.managedObjectContext.save()
              }catch let exception {
                print("Error when saving recent search \(exception.localizedDescription)")
            }

        }

    }

    // MARK:- Return Top 10 Searches

    public class var topSearches: [RecentSearch] {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }

        let fetchRequest = NSFetchRequest<RecentSearch>(entityName: "RecentSearch")

        do {
            let fetchResults = try appDelegate.managedObjectContext.fetch(fetchRequest)

            let results: [RecentSearch] = Array(fetchResults.reversed())

            if results.count > 10 {
                results.forEach { recentItem in
                    let index = results.index(of: recentItem) ?? 0
                    if index > 9 {
                        appDelegate.managedObjectContext.delete(recentItem)
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
