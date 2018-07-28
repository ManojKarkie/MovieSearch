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
    @IBOutlet weak var noMoviesLabel: UILabel!

    private let disposeBag = DisposeBag()
    fileprivate var searchVm = MovieSearchViewModel()

    fileprivate let searchController = UISearchController(searchResultsController: nil)


    //MARK:- TableView Datasource and Delegate
    lazy var tvDelegate:MovieListTableViewDelegate = {
        return MovieListTableViewDelegate(vm: searchVm)
    }()

    lazy var tvDataSource:MovieListTableViewDataSource = {
        return MovieListTableViewDataSource(vm: searchVm)
    }()

    private struct Constants {
        static let searchBarPlaceHolder = "Enter movie name"
        static let errorAlertTitle = "Error!"
        static let tableViewEstimatedHeight: CGFloat = 200.0
        static let searchBarTintColor =  UIColor(red: 0, green: 144.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        static let emptyResultLogo = "noResult"
        static let emptyTitle = "No movies found"
        static let emptyDescription = "No movies found for your search"
    }

//    fileprivate lazy var emptyResultView: EmptyResultControl = {
//        let emptyView = EmptyResultControl()
//        let emptyVm = EmptyResultViewModel.init(emptyImageName: Constants.emptyResultLogo, emptyTitle: Constants.emptyTitle, emptyDesc: Constants.emptyDescription)
//        return emptyView
//    }()

    // MARK:- ViewConroller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearchBar()
        bindRx()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Careem Movies"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- UI Setup

private extension MovieSearchViewController {

    func setupSearchBar() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = Constants.searchBarPlaceHolder
        searchController.searchBar.tintColor = Constants.searchBarTintColor
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.rx.searchButtonClicked.subscribe(onNext: {
            // Perform Search
            self.noMoviesLabel.isHidden = true
            if !self.searchVm.movies.isEmpty {
                self.searchVm.refresh()
                self.tableView.reloadData()
            }
            self.searchVm.searchMovies()
        }).disposed(by: disposeBag)

        tableView.tableHeaderView = searchController.searchBar
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.tableViewEstimatedHeight
        tableView.delegate = tvDelegate
        tableView.dataSource = tvDataSource
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    }

    func reloadAndManageTableView() {
        tableView.tableFooterView = nil
        self.tableView.reloadData()
    }

    func manageEmptyResult() {
        noMoviesLabel.isHidden = !(searchVm.movies.isEmpty)
    }

}

private extension MovieSearchViewController {

    func bindRx() {
        searchController.searchBar.rx.text.orEmpty.bind(to: searchVm.searchText).disposed(by: disposeBag)

//        searchVm.isLoading.asObservable().map{ !$0 }.bind(to: indicator.rx.isHidden).disposed(by: disposeBag)
        searchVm.isLoadingDriver.drive(onNext: { isLoading in
            self.indicator.isHidden = !(isLoading && self.searchVm.isFirstPage)
        }).disposed(by: disposeBag)

        searchVm.successDriver.filter {  return $0 == true }.drive(onNext: { [weak self] _ in
            self?.manageEmptyResult()
            self?.reloadAndManageTableView()
        }).disposed(by: disposeBag)

        searchVm.errorDriver.filter { return $0 != nil }.drive(onNext: { [weak self] in
            self?.tableView.tableFooterView = nil
            self?.showAlert(title: Constants.errorAlertTitle, message: $0)
        }).disposed(by: disposeBag)
    }
}

extension MovieSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

    }

}
