//
//  AutoSuggestionViewController.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- Delegate to relay the users selection of Auto Suggestion listed in table view

protocol AutoSuggestionDelegate : class  {
    func didTapSuggestion(suggestion: String?)
}

class AutoSuggestionViewController: UITableViewController, StoryboardInitializable {

    // MARK:- Delegate

    weak var suggestionDelegate: AutoSuggestionDelegate?
    fileprivate var autoSuggestionVm = AutoSuggestionViewModel()

    private struct Constants {
        static let sectionHeaderHeight: CGFloat = 50.0
        static let headerTitleText = "RECENT SEARCHES"
        static let autoSuggestionTvCellIdentifier =  "AutoSuggestionTableViewCell"
    }

    // MARKK:-  ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.view.backgroundColor = AppColor.recentSearchBackgroundColor.value
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        autoSuggestionVm.fetchTopSuggestions()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source

extension AutoSuggestionViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return autoSuggestionVm.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoSuggestionVm.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.autoSuggestionTvCellIdentifier, for: indexPath) as! AutoSuggestionTableViewCell
        cell.setup(searchText: autoSuggestionVm.searchTextFor(row: indexPath.row))
        return cell
    }
}

// MARKK - Table view Delegate

extension AutoSuggestionViewController {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
        headerView.backgroundColor = AppColor.recentSearchBackgroundColor.value
        headerView.frame = CGRect.init(x: 0.0, y: 0.0, width: tableView.bounds.width, height: Constants.sectionHeaderHeight)

        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = AppColor.recentSearchTextColor.value
        titleLabel.font =  UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
        titleLabel.text = Constants.headerTitleText

        let separatorView = UIView()
        separatorView.backgroundColor = AppColor.listSeparatorColor.value

        headerView.addSubview(titleLabel)
        headerView.addSubview(separatorView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20.0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0.0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0.0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.sectionHeaderHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = autoSuggestionVm.searchTextFor(row: indexPath.row)
        suggestionDelegate?.didTapSuggestion(suggestion: suggestion)
    }
}
