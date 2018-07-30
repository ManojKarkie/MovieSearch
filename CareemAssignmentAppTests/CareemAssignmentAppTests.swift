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
        isSearchMovieCalled = true
    }

    override var searchParams: [String : Any] {
        return  ["query": "Batman",
                 "page": 1,
                 "api_key": MovieApi.Api_Key]
    }

    var shouldLoadSecondPage: Bool {
        return movies.count < totalResults
    }

}

class CareemAssignmentAppTests: XCTestCase {

    // Mock Sut
    var sutMock : MockSearchViewModel!
    //var sut : MovieSearchViewModel!

    var controller : MovieSearchViewController!

    // View Model test

    var searchViewModel: MovieSearchViewModel!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controller = MovieSearchViewController.initFromStoryboard(name: "MovieSearch")
        sutMock = MockSearchViewModel()
        //sut = MovieSearchViewModel()

        controller.searchVm = sutMock
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sutMock = nil
        // sut = nil
        controller = nil
    }

    func testIfSearchMovieCalled() {

        // When

        sutMock.searchMovies()

        // Then

        XCTAssertTrue(sutMock.isSearchMovieCalled)
    }

    func testForPagination() {

        // Expectation

        let successExpection = expectation(description: "Movie Search Succeed")

        // When

        sutMock.searchText.value = "Batman"

        MovieFetcher.fetchMovies(searchParams: sutMock.searchParams, success: {  result in

            self.sutMock.searchResult = result

            (self.sutMock.searchResult?.movies ?? []).forEach {
                self.sutMock.movies.append($0)
            }

            self.sutMock.saveSearch(searchResult: result)
            self.sutMock.managePageNumber()
            successExpection.fulfill()

        }) { errorMessage in
            print("failure")
        }

        wait(for: [successExpection], timeout: 4)

        // Then

        XCTAssertTrue(sutMock.shouldLoadSecondPage)

    }

    func testSearchButtonPressAndIndicator() {

        // When

        //sutMock.searchMovies()

        // Then

        // XCTAssertTrue(controller.indicator.isHidden == false)

    }

}
