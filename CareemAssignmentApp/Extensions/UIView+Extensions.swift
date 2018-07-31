//
//  UIView+Extensions.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/31/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

extension UIView {

    func set(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }

}

