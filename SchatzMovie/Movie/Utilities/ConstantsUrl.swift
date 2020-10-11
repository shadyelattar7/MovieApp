//
//  ConstantsUrl.swift
//  Movie
//
//  Created by Elattar on 8/21/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation

struct MovieURL {
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=8b36bb045c454c225dde292662d9757c"
    static let topRate = "https://api.themoviedb.org/3/movie/top_rated?api_key=8b36bb045c454c225dde292662d9757c&language=en-US"
    static let popular = "https://api.themoviedb.org/3/movie/popular?api_key=8b36bb045c454c225dde292662d9757c&language=en"
    static let upComing = "https://api.themoviedb.org/3/movie/upcoming?api_key=8b36bb045c454c225dde292662d9757c&language=en"
}
