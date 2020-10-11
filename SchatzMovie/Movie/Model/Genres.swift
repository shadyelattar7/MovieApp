//
//  Genres.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [GenresDetails]
}

struct GenresDetails: Codable{
    let name: String
}
