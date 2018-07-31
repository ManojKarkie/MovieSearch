//
//  AppTheme.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/31/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- App Theme Colors

enum AppColor {
    case baseColor
}

extension AppColor {

    var value: UIColor {
        switch self {
          case .baseColor:
            return UIColor(red: 0, green: 144.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        }
    }
}
