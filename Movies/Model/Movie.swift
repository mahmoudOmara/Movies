//
//  Movie.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import Foundation

class Movie: Codable {

    var vote_average: Double
    var title: String
    var poster_path: String
    var overview: String
    var release_date: String
    
    init(vote_average: Double, title: String, poster_path: String,overview: String, release_date: String) {

        self.vote_average = vote_average
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
    }
}
