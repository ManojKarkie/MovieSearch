//
//  MovieListTableViewHelper.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

class MovieListTableViewDelegate: NSObject, UITableViewDelegate {

    weak var searchVm: MovieSearchViewModel!

    init(vm: MovieSearchViewModel) {
        searchVm = vm
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if searchVm.isLastRow(row: indexPath.row) && searchVm.shouldLoadMore {
            let spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            spinner.color = UIColor(red: 0, green: 144.0/255.0, blue: 81.0/255.0, alpha: 1.0)
            spinner.frame = CGRect.init(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            searchVm.searchMovies()
        }

    }

}

class MovieListTableViewDataSource: NSObject, UITableViewDataSource {

    weak var searchVm: MovieSearchViewModel!

    init(vm: MovieSearchViewModel) {
        searchVm = vm
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVm.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let cellViewModel = searchVm.cellVmFor(row: indexPath.row)!
        movieCell.setup(cellVm: cellViewModel)
        return movieCell
    }

}
