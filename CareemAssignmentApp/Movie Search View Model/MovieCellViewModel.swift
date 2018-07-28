//
//  MovieCellViewModel.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation

struct MovieCellViewModel {

    private let movie: MovieItem

    init(movie: MovieItem) {
        self.movie = movie
    }

    var posterUrl: URL? {
        let posterPath = movie.posterUrl ?? ""
        let fullPath = MovieApi.posterBaseUrlString + posterPath
        return URL(string: fullPath.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    var movieName: String? {
        return movie.name
    }

    var releaseDate: String? {
        return "Release Date \(movie.releaseDate ?? "")"
    }

    var preview: String? {
        return movie.fullOverview
    }

}
