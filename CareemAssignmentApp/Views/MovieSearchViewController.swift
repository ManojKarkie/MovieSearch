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

    // MARK:- IBOutlets
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    fileprivate var searchVm = MovieSearchViewModel()

    fileprivate let searchController = UISearchController(searchResultsController: nil)

    //MARK:- TableView Datasource and Delegate
    var tvDelegate = MovieListTableViewDelegate()

    lazy var tvDataSource:MovieListTableViewDataSource = {
        return MovieListTableViewDataSource(vm: searchVm)
    }()

    private struct Constants {
        static let searchBarPlaceHolder = "Enter movie name"
        static let errorAlertTitle = "Error!"
        static let tableViewEstimatedHeight: CGFloat = 200.0
    }

    // MARK:- ViewConroller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchBar()
        setupTableView()
        bindRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Careem Movie"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- UI Setup

private extension MovieSearchViewController {

    func setupSearchBar() {
        searchController.searchBar.barStyle = .default
        searchController.searchBar.tintColor = UIColor.darkGray
        definesPresentationContext = true
        searchController.searchBar.placeholder = Constants.searchBarPlaceHolder
        searchController.searchBar.rx.searchButtonClicked.subscribe(onNext: {
            // Perform Search
            self.searchVm.searchMovies(searchText: "Movie")
        }).disposed(by: disposeBag)

        tableView.tableHeaderView = searchController.searchBar
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.tableViewEstimatedHeight
        tableView.delegate = tvDelegate
        tableView.dataSource = tvDataSource
    }

}

private extension MovieSearchViewController {

    func bindRx() {

        searchVm.isLoading.asObservable().map{ !$0 }.bind(to: indicator.rx.isHidden).disposed(by: disposeBag)

        searchVm.successDriver.filter {  return $0 == true }.drive(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        searchVm.errorDriver.filter { return $0 != nil }.drive(onNext: { [weak self] in
            self?.showAlert(title: Constants.errorAlertTitle, message: $0)
        }).disposed(by: disposeBag)
    }
}
