//
//  MovieSearchResult.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import ObjectMapper

class MovieSearchResult: Mappable {

    var pageNumber: Int?
    var totalResults: Int = 0
    var totalPages: Int = 0
    var movies: [MovieItem] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        pageNumber <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        movies <- map["results"]
    }

}
