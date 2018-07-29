//
//  String+Extensions.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/29/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import Foundation

extension String {

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }

    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
}
