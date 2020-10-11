//
//  Movie.swift
//  Movie
//
//  Created by Elattar on 8/21/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation
struct Movies: Codable {
    let results: [movieDetails]
}

struct movieDetails: Codable {
    
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let release_date: String
    let original_title: String
    
}
