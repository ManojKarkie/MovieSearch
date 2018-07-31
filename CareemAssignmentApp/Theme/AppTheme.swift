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
    case searchBarTintColor
    case listSeparatorColor
    case recentSearchTextColor
    case recentSearchBackgroundColor
}

extension AppColor {

    var value: UIColor {
        switch self {
          case .baseColor:
            return UIColor(red: 0, green: 144.0/255.0, blue: 81.0/255.0, alpha: 1.0)
          case .searchBarTintColor:
            return UIColor(white: 0.9, alpha: 0.9)
          case .listSeparatorColor:
            return UIColor.init(hex: "#EBEBF1")
         case .recentSearchTextColor:
            return UIColor.init(hex: "#424242")
        case .recentSearchBackgroundColor:
            return UIColor.init(hex: "#F7F7F6")

        }
    }
}
