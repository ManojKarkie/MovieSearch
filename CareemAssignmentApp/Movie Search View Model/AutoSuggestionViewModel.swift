//
//  AutoSuggestionViewModel.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation

struct AutoSuggestionViewModel {

    fileprivate var topSuggestions:[RecentSearch] = []

    mutating func fetchTopSuggestions() {
        topSuggestions = RecentSearch.topSearches
    }

}

// MARK:- Table View Helpers

extension AutoSuggestionViewModel {

    var numberOfSection: Int {
        return 1
    }

    var numberOfRows: Int {
        return topSuggestions.count
    }

    var rowHeight: Int {
        return 50
    }

    func searchTextFor(row: Int) -> String? {
        return topSuggestions[row].searchText
    }

}
