//
//  MoviesVCPresenter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/3/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesView: class {
    var presenter: MoviesVCPresenter? { get set }
    func fetchingDataSuccess()
    func addingOfflineMovieSuccess()
    func showError(error: String)
}

protocol MovieCellView: class {
    func displayTitle(title: String)
    func displayPoster(image: UIImage?)
    func displayOverview(overview: String)
    func displayProductionYear(year: String)
    func displayRate(rate: String)
}


class MoviesVCPresenter {
    private weak var view: MoviesView?
    private let interactor: MoviesInteractor
    private let router: MoviesVCRouter
    
    var movies = [Movie]()
    var offlineMovies = [OfflineMovie]()
    
    var lastRequestedPageNumber = 0
    var existingPageNumber = 0
    
    init(view: MoviesView?, interactor: MoviesInteractor, router: MoviesVCRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getNextMoviesPage() {
        guard lastRequestedPageNumber == existingPageNumber else { return }
        lastRequestedPageNumber += 1
        interactor.getMovies(forPageNumber: lastRequestedPageNumber, callBack: { [weak self] (response) in
            guard let self = self else { return }
            self.existingPageNumber += 1
            self.movies.append(contentsOf: response)
            self.view?.fetchingDataSuccess()
        }) { (err) in
            self.lastRequestedPageNumber -= 1
            self.getNextMoviesPage()
            self.view?.showError(error: "")
        }
        
    }
    
    func addMovie()  {
        router.navigateToAddMovieScreen(from: view, delegate: self)
    }
    
    func viewDidLoad() {
        getNextMoviesPage()
    }
    
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getOfflineMoviesCount() -> Int {
        return offlineMovies.count
    }
    
    func configure(cell: MovieCellView, for index: Int) {
        let movie = movies[index]
        cell.displayTitle(title: movie.title)
        (cell as! MovieTVC).imageUrlString = movie.poster_path
        interactor.getImageFromURL(urlString: movie.poster_path) { (image) in
            if (cell as! MovieTVC).imageUrlString == movie.poster_path {
                cell.displayPoster(image: image)
            }
        }
        cell.displayOverview(overview: movie.overview)
        let productionYear = movie.release_date.components(separatedBy: "-").first ?? ""
        cell.displayProductionYear(year: productionYear)
        cell.displayRate(rate: "\(movie.vote_average)")
    }
    
    func configure(offlineCell: MovieCellView, for index: Int) {
        let movie = offlineMovies[index]
        offlineCell.displayTitle(title: movie.title)
        (offlineCell as! MovieTVC).imageUrlString = nil
        offlineCell.displayPoster(image: movie.image)
        offlineCell.displayOverview(overview: movie.overview)
        let productionYear = movie.release_date.components(separatedBy: "-").first ?? ""
        offlineCell.displayProductionYear(year: productionYear)
        offlineCell.displayRate(rate: "\(movie.vote_average)")
    }
    
}


extension MoviesVCPresenter: AddMovieVCDelegate {
    func addMovie(movie: OfflineMovie) {
        offlineMovies.append(movie)
        view?.addingOfflineMovieSuccess()
    }
}
