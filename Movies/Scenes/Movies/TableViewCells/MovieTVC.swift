//
//  MovieTVC.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/2/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

class MovieTVC: UITableViewCell {
    
    @IBOutlet weak var tittleL: UILabel!
    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var overviewL: UILabel!
    @IBOutlet weak var productionYearL: UILabel!
    @IBOutlet weak var rateL: UILabel!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingV: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var imageUrlString: String?
    
    func setupForLoading() {
        imageUrlString = nil
        tittleL.text = "Loading..."
        loadingV.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func reset() {
        posterIV.image = nil
        imageLoadingIndicator.startAnimating()
        loadingV.isHidden = true
    }
    
}
