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
    var success = Variable<Bool>(false)
    var error = Variable<String?>(nil)

    // Observables/Drivers

    var isLoadingDriver : Driver<Bool> {
        return isLoading.asDriver()
    }

    var successDriver: Driver<Bool> {
        return success.asDriver()
    }

    var errorDriver: Driver<String?> {
        return error.asDriver()
    }

    var searchText = Variable<String>("")

    fileprivate var pageNumber = 1

    var searchResult: MovieSearchResult?

    var movies: [MovieItem] = []

    var totalResults: Int {
        return searchResult?.totalResults ?? 0
    }

    var searchParams: [String: Any] {

        return ["query": searchText.value,
                "page": pageNumber,
                "api_key": MovieApi.Api_Key]
    }

    // MARK:- Call Search Movie Api
    func searchMovies() {

        self.isLoading.value = true

        MovieFetcher.fetchMovies(searchParams: self.searchParams, success: { [weak self] result in
            self?.isLoading.value = false
            self?.searchResult = result

            (self?.searchResult?.movies ?? []).forEach {
                self?.movies.append($0)
            }

            self?.saveSearch(searchResult: result)
            self?.managePageNumber()
            self?.success.value = true
        }) { errorMessage in
            self.isLoading.value = false
            self.error.value = errorMessage
        }
    }

    func refresh() {
        movies = []
        pageNumber = 1
    }

}

// MARK:- TableView Helpers and Pagination Management

extension MovieSearchViewModel {

    var numberOfRows: Int {
        return movies.count
    }

    func cellVmFor(row: Int) -> MovieCellViewModel? {
        let cellVm = MovieCellViewModel.init(movie: movies[row])
        return cellVm
    }

}

// MARK:- Pagination

extension MovieSearchViewModel {

    func managePageNumber() {
        if !movies.isEmpty {
            pageNumber += 1
            return
        }
        pageNumber = 1
    }

    func isLastRow(row: Int) -> Bool {
        return row == movies.count - 1
    }

    var isFirstPage: Bool {
        return pageNumber == 1
    }

    var shouldLoadMore: Bool {
        //return movies.count < totalResults && !self.searchText.value.isEmpty
        return movies.count < totalResults
    }

}

// MARK:- Recent Search management

extension MovieSearchViewModel {

    func saveSearch(searchResult: MovieSearchResult) {
        if !self.searchText.value.isEmpty && !searchResult.movies.isEmpty  {
            RecentSearch.saveRecent(text: self.searchText.value)
        }
    }
}
