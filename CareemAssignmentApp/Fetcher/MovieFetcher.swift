//
//  MovieFetcher.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation
import Alamofire

typealias MovieSearchSuccessHandler = ([MovieItem]) -> Void
typealias MovieSearchFailureHandler =  (String) -> Void

struct MovieFetcher {

    static func fetchMovies(searchText: String, page: Int, success: @escaping MovieSearchSuccessHandler, failure: @escaping MovieSearchFailureHandler) {


        


    }

}
