//
//  MovieSearchViewModel.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation

struct MovieSearchViewModel {

    func searchMovies(searchText: String) {

        MovieFetcher.fetchMovies(searchText: searchText, page: 1, success: { result in

        }) { errorMessage in

        }
    }

}
