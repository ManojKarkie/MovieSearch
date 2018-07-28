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

typealias MovieSearchSuccessHandler = (MovieSearchResult) -> Void
typealias MovieSearchFailureHandler =  (String) -> Void

struct MovieFetcher {

    static func fetchMovies(searchText: String, page: Int, success: @escaping MovieSearchSuccessHandler, failure: @escaping MovieSearchFailureHandler) {
        Alamofire.request(MovieApi.searchEndPoint, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            switch response.result {
            case let .success(value):
                let resultDict = value as?  [String: Any] ?? [:]
                if let result  = MovieSearchResult(JSON: resultDict) {
                    success(result)
                    print("Final result \(result)")
                    return
                }
                failure("Something went wrong, Please try again later.")
                break
            case let .failure(error):
                print("search error\(error.localizedDescription)")
                break
            }
        }
    }

}
