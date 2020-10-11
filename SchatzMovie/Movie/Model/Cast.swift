//
//  Cast.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation

struct Cast: Codable{
    
    var cast: [CastDetails]
}


struct CastDetails: Codable {
    
    var character: String
    var name: String
    var profile_path: String?
}
