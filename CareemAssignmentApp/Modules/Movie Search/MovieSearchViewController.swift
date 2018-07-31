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

    // MARK:- RxSwift Dispose Bag
    private let disposeBag = DisposeBag()

    // MARK:- View Model
    var searchVm = MovieSearchViewModel()

    fileprivate lazy var autoSuggestVc: AutoSuggestionViewController =  {
        let vc = AutoSuggestionViewController.initFromStoryboard(name: "AutoSuggestion")
        vc.suggestionDelegate = self
        return vc
    }()

    lazy var searchController: UISearchController = {
       let controller =  UISearchController(searchResultsController: self.autoSuggestVc)
        return controller
    } ()

    //MARK:- TableView Datasource and Delegate
    lazy var tvDelegate:MovieListTableViewDelegate = {
        return MovieListTableViewDelegate(vm: searchVm)
    }()

    lazy var tvDataSource:MovieListTableViewDataSource = {
        return MovieListTableViewDataSource(vm: searchVm)
    }()

    // MARK:- Constants
    private struct Constants {
        static let searchBarPlaceHolder = "Enter movie name"
        static let errorAlertTitle = "Error!"
        static let tableViewEstimatedHeight: CGFloat = 200.0
        static let searchBarTintColor =  UIColor(red: 0, green: 144.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        static let emptyResultLogo = "noResult"
        static let emptyTitle = "No movies found"
        static let emptyDescription = "No movies found for your search"
    }

    // MARK:- Empty State View
    fileprivate lazy var emptyResultView: EmptyResultControl = {
        let emptyView = EmptyResultControl()
        let emptyVm = EmptyResultViewModel.init(emptyImageName: Constants.emptyResultLogo, emptyTitle: Constants.emptyTitle, emptyDesc: Constants.emptyDescription)
        emptyView.setup(vm: emptyVm)
        return emptyView
    }()

    // MARK:- ViewConroller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearchBar()
        bindVm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- UI Setup and Management

private extension MovieSearchViewController {

    func setupSearchBar() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = Constants.searchBarPlaceHolder
        searchController.searchBar.tintColor = UIColor.darkGray
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.rx.searchButtonClicked.subscribe(onNext: {
            // Perform Search
            self.reloadAndSearch()
        }).disposed(by: disposeBag)
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.tableViewEstimatedHeight
        tableView.delegate = tvDelegate
        tableView.dataSource = tvDataSource
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        tableView.backgroundView = self.emptyResultView
        tableView.backgroundView?.isHidden = true
    }

    func reloadAndManageTableView() {
        tableView.tableFooterView = nil
        self.tableView.reloadData()
    }

    func manageEmptyResult() {
        tableView.backgroundView?.isHidden = !(searchVm.movies.isEmpty)
    }

}

// MARK:- View Model Binding

private extension MovieSearchViewController {

    func bindVm() {
        searchController.searchBar.rx.text.orEmpty.bind(to: searchVm.searchText).disposed(by: disposeBag)

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

// MARK:- Reload And Search

private extension MovieSearchViewController {

    func reloadAndSearch() {

        self.searchController.searchResultsController?.dismiss(animated: false, completion: nil)
        searchController.searchBar.setShowsCancelButton(false, animated: true)

        self.tableView.backgroundView?.isHidden = true
        if !self.searchVm.movies.isEmpty {
            self.searchVm.refresh()
            self.tableView.reloadData()
        }
        self.searchVm.searchMovies()
    }

}

// MARK:- UISearchResultsUpdating Delegate

extension MovieSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
}

// MARK:- Suggestion Delegate

extension MovieSearchViewController: AutoSuggestionDelegate {

    func didTapSuggestion(suggestion: String?) {
        guard let sugg = suggestion else { return }
        searchController.searchBar.text = sugg
        searchVm.searchText.value = sugg
        searchController.searchBar.resignFirstResponder()
        reloadAndSearch()
    }
}
