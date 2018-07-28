//
//  MovieItem.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import ObjectMapper

struct MovieItem: Mappable {

    var posterUrl: String?
    var name: String?
    var releaseDate: String?
    var fullOverview: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        posterUrl <- map["poster_path"]
        name <- map["title"]
        releaseDate <- map["release_date"]
        fullOverview <- map["overview"]
    }
}
