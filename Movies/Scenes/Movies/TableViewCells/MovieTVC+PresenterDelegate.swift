//
//  MovieTVC+PresenterDelegate.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/3/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import Foundation
import UIKit

extension MovieTVC: MovieCellView {
    
    func displayTitle(title: String) {
        self.tittleL.text = title
    }
    
    func displayPoster(image: UIImage?) {
        self.posterIV.image = image
    }
    
    func displayOverview(overview: String) {
        self.overviewL.text = overview
    }
    
    func displayProductionYear(year: String) {
        self.productionYearL.text = year
    }
    
    func displayRate(rate: String) {
        self.rateL.text = "\(rate)"
    }
    
    
    
}
