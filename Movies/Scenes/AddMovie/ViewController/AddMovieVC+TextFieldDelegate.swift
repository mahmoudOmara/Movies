//
//  AddMovieVC+TextFieldDelegate.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/5/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit


extension AddMovieVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
