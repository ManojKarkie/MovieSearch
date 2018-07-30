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

protocol ApiFetcher { }

// MARK:- Success and failure closure typealias

typealias MovieSearchSuccessHandler = (MovieSearchResult) -> Void
typealias MovieSearchFailureHandler =  (String) -> Void

struct MovieFetcher: ApiFetcher {

    static func fetchMovies(searchParams: [String: Any], success: @escaping MovieSearchSuccessHandler, failure: @escaping MovieSearchFailureHandler) {

        Alamofire.request(MovieApi.searchEndPoint, method: .get, parameters: searchParams, encoding: URLEncoding.init(destination: .queryString), headers: nil).validate().responseJSON { response in

            switch response.result {

            case let .success(value):
                let resultDict = value as?  [String: Any] ?? [:]
                print("movies result \(resultDict)")
                if let result  = MovieSearchResult(JSON: resultDict) {
                    success(result)
                    //print("Final result \(result)")
                    return
                }
                failure("Something went wrong, Please try again later.")
                break
            case let .failure(error):
                failure(error.localizedDescription)
                break
            }
        }
    }

}
