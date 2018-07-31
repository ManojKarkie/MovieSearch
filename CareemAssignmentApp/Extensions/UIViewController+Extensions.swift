//
//  UIViewController+Extensions.swift
//  CareemAssignmentApp
//
//  Created by Manoj Karki on 7/27/18.
//  Copyright © 2018 Swiftech. All rights reserved.
//

import UIKit

// MARK:- UIView Controller Extensions, Initialization from storyboard and alert handlers

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }

    func showAlert(title: String?, message: String? = "", actionTitle: String? = "Ok") {

        let alertStyle: UIAlertControllerStyle = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? .alert : .actionSheet

        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
