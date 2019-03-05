//
//  DiscoverMovieJSON.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import Foundation

class DiscoverMovieJSON: Codable {
    var page: Int
    var results: [Movie]
}
