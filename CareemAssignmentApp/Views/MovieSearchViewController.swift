//
//  MovieSearchViewController.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSearchViewController: UIViewController, StoryboardInitializable {

    fileprivate let searchController = UISearchController(searchResultsController: nil)

    // MARK:- ViewConroller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- UI Setup

private extension MovieSearchViewController {

    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .default
        searchController.searchBar.tintColor = UIColor.darkGray
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Enter movie name"
        navigationItem.searchController = searchController
    }

}
