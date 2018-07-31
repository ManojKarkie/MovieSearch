//
//  EmptyResultControl.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/28/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- Empty State View Model

struct EmptyResultViewModel {

    let emptyImageName: String
    let emptyTitle : String
    let emptyDesc : String

}

class EmptyResultControl: UIView {

    // MARK:- IBOutlets

    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    // MARK:- Initialization

    init() {
        super.init(frame: UIScreen.main.bounds)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Populate UI with view model

    func setup(vm: EmptyResultViewModel) {
        self.emptyImageView.image  = UIImage.init(named: vm.emptyImageName)
        self.titleLabel.text = vm.emptyTitle
        self.descLabel.text = vm.emptyDesc
    }
}

private extension EmptyResultControl {

    // MARK:- Load empty result view from EmptyResultView.swift nib file

    func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyResultView", bundle: bundle)
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }
}
