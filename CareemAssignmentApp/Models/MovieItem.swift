//
//  MovieItem.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import ObjectMapper

class MovieItem: Mappable {

    var posterUrl: String?
    var name: String?
    var releaseDate: String?
    var fullPreview: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        posterUrl <- map["poster_path"]
        name <- map["title"]
        releaseDate <- map["release_date"]
        fullPreview <- map["preview"]
    }
}
