//
//  ViewController.swift
//  Movie
//
//  Created by Elattar on 8/21/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import Gemini
import SDWebImage

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    let cellScaling: CGFloat = 0.6
    var movies: [movieDetails] = []
    
    @IBOutlet weak var segment_sc: UISegmentedControl!
    @IBOutlet weak var collectionViewX: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animtionCell()
        fetchMovie_nowPalying()
        customLayout()
        
        

    }
    
    func fetchMovie_nowPalying() {
        APIManager.nowPlaying{ (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.movies = film.results
                self.collectionViewX.reloadData()
            }
        }
    }
    
    func fetchMovie_topRate() {
        APIManager.topRated{ (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.movies = film.results
                self.collectionViewX.reloadData()
            }
        }
    }
    
    func fetchMovie_popular() {
        APIManager.popular{ (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.movies = film.results
                self.collectionViewX.reloadData()
            }
        }
    }
    func fetchMovie_upComing() {
        APIManager.upComing{ (error, movie) in
            if let error = error{
                self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.movies = film.results
                self.collectionViewX.reloadData()
            }
        }
    }
    
    func animtionCell()  {
//        collectionViewX.gemini
//            .scaleAnimation()
//            .scale(0.50)
//            .scaleEffect(.scaleUp)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        //self.collectionViewX.animateCell(cell)
        
        if let movieImgURL = movies[indexPath.row].poster_path{
            cell.moviePoster_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(movieImgURL)"), placeholderImage: UIImage(named: "10"))
        }else{
            print("error")
        }
        
        let rates = movies[indexPath.row].vote_average
        cell.movieRate_lbl.text = "\(rates)"
        cell.movieTitle_lbl.text = movies[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let filmProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! detailsVC
        
        filmProfile.name = movies[indexPath.row].title
        filmProfile.background = movies[indexPath.row].backdrop_path
        filmProfile.overView = movies[indexPath.row].overview
        filmProfile.poster = movies[indexPath.row].poster_path
        filmProfile.rating = movies[indexPath.row].vote_average
        filmProfile.date = movies[indexPath.row].release_date
        filmProfile.originalTitle = movies[indexPath.row].original_title
        filmProfile.id = movies[indexPath.row].id
        
        navigationController?.pushViewController(filmProfile, animated: true)
        
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        self.collectionViewX.animateVisibleCells()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        
//        if let cell = cell as? HomeCVCell{
//            self.collectionViewX.animateCell(cell)
//        }
//    }
    
    @IBAction func segment_btn(_ sender: Any) {
        
        let index = segment_sc.selectedSegmentIndex
        switch index {
        case 0:
            fetchMovie_nowPalying()
            print("Now Playing")
        case 1:
            fetchMovie_upComing()
            print("Coming soon")
        case 2:
            fetchMovie_topRate()
            print("Top rated")
        case 3:
            fetchMovie_popular()
            print("Popular")
        default:
            print("error")
        }
        
    }
 
    
    @IBAction func search_btn(_ sender: Any) {
        
        let searchVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC")
        self.navigationController?.pushViewController(searchVc, animated: true)
    }
    
    
    @IBAction func CoreDate_btn(_ sender: Any) {
        
        let watchlist = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WatchListVC")
        
        self.navigationController?.pushViewController(watchlist, animated: true)
        
      
        
    }
    
    func customLayout(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionViewX!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewX?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
    }
    
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionViewX?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset

    }
}
