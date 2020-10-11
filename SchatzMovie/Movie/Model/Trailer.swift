//
//  Trailer.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation

struct VideoDetails: Codable {
    var key: String
}

struct Video: Codable {
    var results: [VideoDetails]
    
}
