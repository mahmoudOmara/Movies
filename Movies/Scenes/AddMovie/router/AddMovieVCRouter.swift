//
//  AddMovieVCRouter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

protocol AddMovieVCDelegate {
    func addMovie(movie: OfflineMovie)
}

class AddMovieVCRouter {
    
    var delegate: AddMovieVCDelegate?
    
    class func createAddMovieVC(moviesView: MoviesView?, delegate: AddMovieVCDelegate) -> UIViewController {
        let addMovieVC = mainStoryboard.instantiateViewController(withIdentifier: "AddMovie")
        if let addMovieView = addMovieVC as? AddMovieVCView {
            let router = AddMovieVCRouter()
            router.delegate = delegate
            let presenter =  AddMovieVCPresenter(view: addMovieView, router: router)
            addMovieView.presenter = presenter
        }
        return addMovieVC
    }
    
    class var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func navigateBack(router: AddMovieVCRouter, movie: OfflineMovie) {
        self.delegate?.addMovie(movie: movie)
    }
}

