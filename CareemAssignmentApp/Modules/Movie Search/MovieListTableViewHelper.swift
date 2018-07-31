//
//  MovieListTableViewHelper.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- Movie List Table View Delegate

class MovieListTableViewDelegate: NSObject, UITableViewDelegate {

    private struct Constants {
        static let spinnerHeight: CGFloat = 44.0
    }

    weak var searchVm: MovieSearchViewModel!

    init(vm: MovieSearchViewModel) {
        searchVm = vm
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        // MARK:- Evaluate and trigger next page

        if searchVm.isLastRow(row: indexPath.row) && searchVm.shouldLoadMore {
            let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            spinner.color = AppColor.baseColor.value
            spinner.frame = CGRect.init(x: 0.0, y: 0.0, width: tableView.bounds.width, height: Constants.spinnerHeight)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            searchVm.searchMovies()
        }

    }

}

// MARK:- Movie List Table View Data Source

class MovieListTableViewDataSource: NSObject, UITableViewDataSource {

    private struct Constants {
        static let movieTvCellIdentifier =  "MovieTableViewCell"
    }

    weak var searchVm: MovieSearchViewModel!

    init(vm: MovieSearchViewModel) {
        searchVm = vm
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVm.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieTvCellIdentifier, for: indexPath) as! MovieTableViewCell
        let cellViewModel = searchVm.cellVmFor(row: indexPath.row)!
        movieCell.setup(cellVm: cellViewModel)
        return movieCell
    }

}
