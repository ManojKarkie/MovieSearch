//
//  AutoSuggestionTableViewCell.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

class AutoSuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var recentSearchText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(searchText: String?) {
        recentSearchText.text = searchText
    }

}
