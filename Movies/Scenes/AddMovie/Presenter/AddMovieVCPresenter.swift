//
//  AddMovieVCPresenter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

protocol AddMovieVCView: class {
    var presenter: AddMovieVCPresenter? { get set }
    func showErrorMessage(str: String)
}

class AddMovieVCPresenter {
    
    private weak var view: AddMovieVCView?
    private let router: AddMovieVCRouter
    
    init(view: AddMovieVCView?, router: AddMovieVCRouter) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func addMovie(title: String?, overview: String?, rate: Double?, productionYear: String?, image: UIImage?) {
        guard validate(title: title, overview: overview, rate: rate, productionYear: productionYear) else { return }
        
        router.navigateBack(router: router, movie: OfflineMovie(vote_average: rate ?? 0.0,
                                                         title: title ?? "",
                                                         image: image ?? UIImage(named: "defaultMovieImage")!,
                                                         overview: overview ?? "",
                                                         release_date: productionYear ?? ""))
        (view as? UIViewController)?.navigationController?.popViewController(animated: true)
    }
    
    private func validate(title: String?, overview: String?, rate: Double?, productionYear: String?) -> Bool {
        
        if isEmpty(str: title) {
            view?.showErrorMessage(str: "Please insert a title to your movie.")
            return false
        }
        if isEmpty(str: overview) {
            view?.showErrorMessage(str: "Please insert an overview to your movie.")
            return false
        }
        if rate == 0.0 {
            view?.showErrorMessage(str: "Please insert the rate to your movie.")
            return false
        }
        if isEmpty(str: productionYear) {
            view?.showErrorMessage(str: "Please insert production year for your movie.")
            return false
        }
        if Int(productionYear!) == nil {
            view?.showErrorMessage(str: "Please insert a valid production year.")
            return false
        }
        return true
    }
    
    private func isEmpty(str: String?) -> Bool {
        return (str ?? "") == ""
    }
}

