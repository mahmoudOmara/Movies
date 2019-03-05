//
//  OfflineMovie.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/5/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

class OfflineMovie {
    
    var vote_average: Double
    var title: String
    var image: UIImage
    var overview: String
    var release_date: String
    
    init(vote_average: Double, title: String, image: UIImage,overview: String, release_date: String) {
        
        self.vote_average = vote_average
        self.title = title
        self.image = image
        self.overview = overview
        self.release_date = release_date
    }
}
