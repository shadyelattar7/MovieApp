//
//  ApiiManager.swift
//  Movie
//
//  Created by Elattar on 8/21/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static func nowPlaying(completion: @escaping (_ error: String?, _ movie: Movies?) -> ())  {
        //   let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=8b36bb045c454c225dde292662d9757c"
        
        Alamofire.request(MovieURL.nowPlaying, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
            
            switch respones.result{
                
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
                
            case .success(_):
                //   print(respones.result.value)
                guard let data = respones.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                    
                }
                
                do{
                    let movie = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,movie)
                    //                    for i in movie.results{
                    //                        print("Title: \(i.title)")
                    //                    }
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
                
            }
            
        }
    }
    
    
    
    static func topRated(completion: @escaping (_ error: String?, _ topRated: Movies?)->()){
        //            let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=8b36bb045c454c225dde292662d9757c&language=en-US"
        
        Alamofire.request(MovieURL.topRate, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result{
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):
                guard let data = response.data else{
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                
                do{
                    
                    let topRated = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,topRated)
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
            }
        }
    }
    
    static func popular(completion: @escaping (_ error: String?, _ topRated: Movies?)->()){
        
        Alamofire.request(MovieURL.popular, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result{
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):
                guard let data = response.data else{
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                
                do{
                    
                    let topRated = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,topRated)
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
            }
        }
    }
    
    static func upComing(completion: @escaping (_ error: String?, _ topRated: Movies?)->()){
        
        Alamofire.request(MovieURL.upComing, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result{
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):
                guard let data = response.data else{
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                
                do{
                    
                    let topRated = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,topRated)
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
            }
        }
    }
    
    static func search (_ name: String,_ language: String,completion: @escaping (_ error: String?, _ movie: Movies?)->()){
        
        let url = "http://api.themoviedb.org/3/search/movie?api_key=8b36bb045c454c225dde292662d9757c&query=\(name)&year=&language=\(language)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):
                //  print("Value: \(response.result.value)")
                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                do{
                    let film = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,film)
                    //                    for i in film.results{
                    //                        print("Title: \(i.title)")
                    //                    }
                    
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
            }
        }
        
    }
    
    static func video(_ id: Int,completion: @escaping (_ error: String?, _ movie: Video?) -> ())  {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=8b36bb045c454c225dde292662d9757c&language=en-US"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
                        
            switch respones.result{
            
            case .failure(let error):
                print("Error alamofire")
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
                
            case .success(_):
                //   print(respones.result.value)
                guard let data = respones.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                    
                }
                
                do{
                    let movie = try JSONDecoder().decode(Video.self, from: data)
                    completion(nil,movie)
                    //                    for i in movie.{
                    //                        print("Title: \(i.name)")
                    //                    }
                }catch{
                    print("Error trying to decode response Gen")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
                
            }
            
        }
    }
    
    
    static func cast(_ id: Int,completion: @escaping (_ error: String?, _ movie: Cast?) -> ())  {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=8b36bb045c454c225dde292662d9757c"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
            
            switch respones.result{
                
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
                
            case .success(_):
                //   print(respones.result.value)
                guard let data = respones.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                    
                }
                
                do{
                    let movie = try JSONDecoder().decode(Cast.self, from: data)
                    completion(nil,movie)
//                    for i in movie.cast{
//                        print("Title: \(i.name)")
//                    }
                }catch{
                    print("Error trying to decode response Gen")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
                
            }
            
        }
    }
    
    static func genres(_ id: Int,completion: @escaping (_ error: String?, _ movie: Genres?) -> ())  {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=8b36bb045c454c225dde292662d9757c&language=en-US"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
            
            switch respones.result{
                
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
                
            case .success(_):
                //   print(respones.result.value)
                guard let data = respones.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                    
                }
                
                do{
                    let movie = try JSONDecoder().decode(Genres.self, from: data)
                    completion(nil,movie)
                    for i in movie.genres{
                        print("Title: \(i.name)")
                    }
                }catch{
                    print("Error trying to decode response Gen")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
                
            }
            
        }
    }
    
    
}
