//
//  AutoSuggestionViewController.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

class AutoSuggestionViewController: UITableViewController, StoryboardInitializable {

    // MARKK:-  ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.view.backgroundColor = UIColor.init(hex: "#F7F7F6")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source

extension AutoSuggestionViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
}

// MARKK - Table view Delegate

extension AutoSuggestionViewController {

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(hex: "#F7F7F6")
        headerView.frame = CGRect.init(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)

        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.init(hex: "#424242")
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
        titleLabel.text =  "Recent Searches"

        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.init(hex: "#EBEBF1")

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
        return 44.0
    }
}
