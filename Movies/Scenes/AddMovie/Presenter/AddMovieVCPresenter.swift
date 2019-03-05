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
        router.navigateBack(router: router, movie: OfflineMovie(vote_average: rate ?? 0.0,
                                                         title: title ?? "",
                                                         image: image ?? UIImage(named: "defaultMovieImage")!,
                                                         overview: overview ?? "",
                                                         release_date: productionYear ?? ""))
        (view as? UIViewController)?.navigationController?.popViewController(animated: true)
    }
}

