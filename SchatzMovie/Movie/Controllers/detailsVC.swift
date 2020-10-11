//
//  detailsVC.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import SDWebImage
import YouTubePlayer

class detailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var background_img: UIImageView!
    @IBOutlet weak var poster_img: UIImageView!
    @IBOutlet weak var movieTitle_lbl: UILabel!
    @IBOutlet weak var rate_lbl: UILabel!
    @IBOutlet weak var originalTitle_lbl: UILabel!
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var genres_lbl: UILabel!
    @IBOutlet weak var description_tview: UITextView!
    @IBOutlet weak var infoGround_img: UIImageView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var cast_collView: UICollectionView!
    @IBOutlet weak var yearDate_lbl: UILabel!
    @IBOutlet weak var addWatchList: UIButton!
    @IBOutlet weak var egyBest: UIButton!
    
    var name: String?
    var overView: String?
    var poster: String?
    var background: String?
    var rating: Double?
    var originalTitle:  String?
    var date: String?
    var id: Int = 0
    var trailer: [VideoDetails] = []
    var cast: [CastDetails] = []
    var genresId: [GenresDetails] = []
    var movieGenres: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWatchList.layer.cornerRadius = 15
        egyBest.layer.cornerRadius = 15
        
        fetchTrailer(idMovie: id)
        fetchCast(idMovie: id)
        fetchGenres(idMovie: id) 
        
        if let backgroundMovie = background{
            background_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(backgroundMovie)"), placeholderImage: UIImage(named: "10"))
        }
        
        if let posterMovie = poster{
            infoGround_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "10"))
        }
        
        if let infoBackground = poster{
            poster_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(infoBackground)"), placeholderImage: UIImage(named: "10"))
        }
        
        movieTitle_lbl.text = name
        description_tview.text = overView
        rate_lbl.text = "\(rating!)"
        date_lbl.text = date
        originalTitle_lbl.text = originalTitle
        yearDate_lbl.text = dateMovie(date!)
    }
    
    func fetchTrailer(idMovie: Int)  {
        APIManager.video(idMovie){ (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.trailer = film.results

                for i in self.trailer{
                if let myVideoURL = URL(string: "https://www.youtube.com/watch?v=\(i.key)"){
                self.videoPlayer.loadVideoURL(myVideoURL)
                }else{
                    print("error")
                    return
                }
            }
            }
        }
    }
    
    func fetchCast(idMovie: Int)  {
        APIManager.cast(idMovie) { (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.cast = film.cast
                self.cast_collView.reloadData()
            }
        }
    }
    
    
    func fetchGenres(idMovie: Int)  {
        APIManager.genres(idMovie) { (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.genresId = film.genres
                for i in self.genresId{
                    self.movieGenres.append(i.name)
                }
                let G = self.movieGenres.joined(separator: " , ")
                self.genres_lbl.text = G
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cast.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollVCell", for: indexPath) as! CastCollVCell
        
        if let movieImgURL = cast[indexPath.row].profile_path{
            cell.actorPhoto_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(movieImgURL)"), placeholderImage: UIImage(named: "10"))
        }else{
            print("error image")
        }
        
        cell.actorName_lbl.text = cast[indexPath.row].name
        cell.charName_lbl.text = cast[indexPath.row].character
        
        return cell
        
    }
    
    @IBAction func addWatchList_btn(_ sender: Any) {
        
        let movie = MoviesList(context: context)
        movie.title = name
        movie.overview = overView
        movie.date = date
        movie.poster = poster
        movie.rate = rating!
        movie.background_img = background
        
        do{
            appDelegate.saveContext()
            print("Save")
        }catch{
            print("Problem in Save")
        }
        
    }
    
    @IBAction func egyBest_btn(_ sender: Any) {
        
        let egyBest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EgyBestVC") as! EgyBestVC
       
        //s7 kda ?
        egyBest.name = name!
        egyBest.data = date!
        
        self.navigationController?.pushViewController(egyBest, animated: true)
        
    }
    
}
