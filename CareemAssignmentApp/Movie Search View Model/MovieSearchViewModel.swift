//
//  MovieSearchViewModel.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieSearchViewModel {

    var isLoading = Variable<Bool>(false)
    fileprivate var success = Variable<Bool>(false)
    fileprivate var error = Variable<String?>(nil)

    // Observables/Drivers

    var successDriver: Driver<Bool> {
        return success.asDriver()
    }

    var errorDriver: Driver<String?> {
        return error.asDriver()
    }

    var searchResult: MovieSearchResult?

    func searchMovies(searchText: String) {
        self.isLoading.value = true
        MovieFetcher.fetchMovies(searchText: searchText, page: 1, success: { [weak self] result in
            self?.isLoading.value = false
            self?.searchResult = result
            self?.success.value = true
        }) { errorMessage in
            self.isLoading.value = false
            self.error.value = errorMessage
        }
    }

}

// MARK:- TableView Helpers

extension MovieSearchViewModel {

    var numberOfRows: Int {
        return searchResult?.movies.count ?? 0
    }

    func cellVmFor(row: Int) -> MovieCellViewModel? {
        guard let result = searchResult else { return nil }
        let cellVm = MovieCellViewModel.init(movie: result.movies[row])
        return cellVm
    }

}
