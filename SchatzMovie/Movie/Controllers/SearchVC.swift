//
//  SearchVC.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import NaturalLanguage

class SearchVC: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    var lastMovies: [movieDetails] = []
    var searchResult: [movieDetails] = []
    var searching: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table_VC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        table_VC.isHidden = true
        table_VC.keyboardDismissMode = .onDrag
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchResult.count
        }else{
            return lastMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell", for: indexPath) as! SearchTVCell
        
        if searching{
            cell.movieTitle_lbl.text = searchResult[indexPath.row].original_title
            if let movieImgURL = searchResult[indexPath.row].poster_path{
                cell.poster_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(movieImgURL)"), placeholderImage: UIImage(named: "10"))
            }
            let dateFilm = searchResult[indexPath.row].release_date
            
            cell.movieDate_lbl.text =  dateMovie(dateFilm)
            
        }else{
            cell.movieTitle_lbl.text = lastMovies[indexPath.row].original_title
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(searchResult[indexPath.row].title)
        
        let filmProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! detailsVC
        
        filmProfile.name = searchResult[indexPath.row].title
        filmProfile.background = searchResult[indexPath.row].backdrop_path
        filmProfile.overView = searchResult[indexPath.row].overview
        filmProfile.poster = searchResult[indexPath.row].poster_path
        filmProfile.rating = searchResult[indexPath.row].vote_average
        filmProfile.date = searchResult[indexPath.row].release_date
        filmProfile.originalTitle = searchResult[indexPath.row].original_title
        filmProfile.id = searchResult[indexPath.row].id
        
        navigationController?.pushViewController(filmProfile, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func dateMovie(_ year: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: year){
            return dateFormatterPrint.string(from: date)
        }
        return "nill"
    }
    
    func fetchMovie (searchText: String){
        
        var all: String = ""
        //    var languge: String = ""
        all = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let lang = detectedLangauge(for: all)!

        APIManager.search(all, lang) { (error, apiResult) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let apiResults = apiResult{
                self.lastMovies = apiResults.results
                
                self.searchResult = self.lastMovies.filter({ (movie) -> Bool in
                    if movie.original_title.prefix(searchText.count).lowercased() == searchText.lowercased(){
                        return true
                    }
                    
                    return false
                })                
                self.searchResult = self.lastMovies.filter({$0.original_title.prefix(searchText.count).lowercased() == searchText.lowercased()})
                self.table_VC.reloadData()
            }
        }
    }
    
    func detectedLangauge(for string: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLangauge = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLangauge
    }
    
}

extension SearchVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        if searchBar.text!.isEmpty {
            print("Error Empty")
            table_VC.isHidden = true
        }else{
            table_VC.isHidden = false
            fetchMovie(searchText: searchText)
            searching = true
            table_VC.reloadData()
        }
        
        
    }
}
