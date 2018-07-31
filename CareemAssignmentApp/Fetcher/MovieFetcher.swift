//
//  MovieFetcher.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

// MARK:- Success and failure closures

typealias MovieSearchSuccessHandler = (_ result: MovieSearchResult) -> Void
typealias MovieSearchFailureHandler =  (_ error: String) -> Void

// MARK:- Fetcher Protocol

protocol MovieFetcherProtocol {
   static func fetchMovies(searchParams: [String: Any], success: @escaping MovieSearchSuccessHandler, failure: @escaping MovieSearchFailureHandler)
}

// MARK:- Constants

struct FetcherConstants {
    static let somethingWentWrong = "Something went wrong, Please try again later."
}

struct MovieFetcher: MovieFetcherProtocol {

    static func fetchMovies(searchParams: [String: Any], success: @escaping MovieSearchSuccessHandler, failure: @escaping MovieSearchFailureHandler) {

        Alamofire.request(MovieApi.searchEndPoint, method: .get, parameters: searchParams, encoding: URLEncoding.init(destination: .queryString), headers: nil).validate().responseJSON { response in

            switch response.result {

            case let .success(value):
                let resultDict = value as?  [String: Any] ?? [:]
                if let result  = MovieSearchResult(JSON: resultDict) {
                    success(result)
                    return
                }
                failure(FetcherConstants.somethingWentWrong)
                break
            case let .failure(error):
                failure(error.localizedDescription)
                break
            }
        }
    }

}
