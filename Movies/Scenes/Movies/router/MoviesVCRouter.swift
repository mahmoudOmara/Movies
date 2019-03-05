//
//  MoviesVCPresenter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/3/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//


import UIKit

class MoviesVCRouter {
    
    class func createMoviesVC() -> UIViewController {
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "UINavigationController")
        let moviesView = navigationController.children.first as? MoviesView
        let interactor = MoviesInteractor()
        let router = MoviesVCRouter()
        let presenter = MoviesVCPresenter(view: moviesView, interactor: interactor, router: router)
        moviesView?.presenter = presenter
        return navigationController
    }
    
    class var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func navigateToAddMovieScreen(from view: MoviesView?, delegate: AddMovieVCDelegate) {
        let AddMovieView = AddMovieVCRouter.createAddMovieVC(moviesView: view, delegate: delegate)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(AddMovieView, animated: true)
        }
    }
    
}
