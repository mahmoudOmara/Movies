//
//  MoviesVC+PresenterDelegate.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/3/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit


extension MoviesVC: MoviesView {
    
    func fetchingDataSuccess() {
        moviesTV.reloadData()
    }
    
    func addingOfflineMovieSuccess() {
        moviesTV.reloadData()
        moviesTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func showError(error: String) {
        print(error.description)
    }
    
    
}


