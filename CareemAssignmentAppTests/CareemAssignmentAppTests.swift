//
//  CareemAssignmentAppTests.swift
//  CareemAssignmentAppTests
//
//  Created by Manoj Karki on 7/31/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import XCTest
@testable import CareemAssignmentApp

import RxCocoa
import RxSwift

class MockSearchViewModel: MovieSearchViewModel {

    var isSearchMovieCalled = false

    override func searchMovies() {
        super.searchMovies()
        isSearchMovieCalled = true
    }

}

class CareemAssignmentAppTests: XCTestCase {

    // System Under Test
    var sut : MockSearchViewModel!

    var controller : MovieSearchViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        controller = MovieSearchViewController.initFromStoryboard(name: "MovieSearch")
        sut = MockSearchViewModel()
        controller.searchVm = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
        controller =  nil
    }

    // Test whether search movie is called

    func testIfSearchMovieCalled() {

        // When

        sut.searchMovies()

        // Then

        XCTAssertTrue(sut.isSearchMovieCalled)
    }

    // Test whether movie search succeeds for valid search text

    func testForSearchMovieSuccess() {

        // Given
        sut.searchText.value = "Batman"

        let successExpection = expectation(description: "Success Closure called")

        // When

        MovieFetcher.fetchMovies(searchParams: sut.searchParams, success: {  result in

            self.sut.searchResult = result

            (self.sut.searchResult?.movies ?? []).forEach {
                self.sut.movies.append($0)
            }

            self.sut.managePageNumber()
            successExpection.fulfill()

        }) { errorMessage in
            XCTFail(errorMessage)
        }

        wait(for: [successExpection], timeout: 4)

        // Then

        XCTAssertTrue(!sut.movies.isEmpty)
    }

    // Test Whether pagination is working for search text with multiple pages of result

    func testForPagination() {

        // Given

        sut.searchText.value = "Batman"

        // Expectation

        let successExpection = expectation(description: "Movie Search Succeed")

        // When

        MovieFetcher.fetchMovies(searchParams: sut.searchParams, success: {  result in

            self.sut.searchResult = result

            (self.sut.searchResult?.movies ?? []).forEach {
                self.sut.movies.append($0)
            }

            self.sut.managePageNumber()
            successExpection.fulfill()

        }) { errorMessage in
            print("failure")
        }

        wait(for: [successExpection], timeout: 4)

        // Then

        XCTAssertTrue(sut.shouldLoadMore)

    }

    // Test whether loading flag is set to true when search movie api called from view model

    func testSearchButtonPressAndIndicator() {

        // When

        sut.searchMovies()

        // Then

         XCTAssertTrue(sut.isLoading.value == true)

    }
}
