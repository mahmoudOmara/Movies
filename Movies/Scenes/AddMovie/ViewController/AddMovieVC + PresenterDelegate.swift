//
//  AddMovieVC + PresenterDelegate.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

extension AddMovieVC: AddMovieVCView {
    func showErrorMessage(str: String) {
        let alert = UIAlertController.init(title: "Missing Field", message: str, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
