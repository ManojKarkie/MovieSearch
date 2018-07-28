//
//  MovieListTableViewHelper.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

class MovieListTableViewDelegate: NSObject, UITableViewDelegate {}

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
