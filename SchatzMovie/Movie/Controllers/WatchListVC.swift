//
//  WatchListVC.swift
//  Movie
//
//  Created by Elattar on 9/10/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import CoreData

class WatchListVC: UIViewController {
    
    var film: [MoviesList] = []
    var trash: UIBarButtonItem!
    
    @IBOutlet weak var collectionViewX: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewX.register(UINib(nibName: "WatchListCell", bundle: nil), forCellWithReuseIdentifier: "WatchListCell")
        collectionViewX.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        navigationItem.title = "Watch List"
        loadMovie()
        
        let backBtn = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backAction))
        
        trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBtn))
        trash?.isEnabled = false
        
        navigationItem.rightBarButtonItems = [trash] as? [UIBarButtonItem]
        
        navigationItem.leftBarButtonItems = [backBtn,editButtonItem]
    }
    
    @objc func trashBtn (){
        print("Delete Item")
        if let selectCells = collectionViewX.indexPathsForSelectedItems{
            let items = selectCells.map{$0.item}.sorted().reversed()
            for item in items{
                let movie = film[item]
                context.delete(movie)
                film.remove(at: item)
                appDelegate.saveContext()
            }
            collectionViewX.deleteItems(at: selectCells)
            trash?.isEnabled = false
        }
    }
    
    @objc func backAction (){
        self.navigationController?.popViewController(animated: true)
    }
    
     func loadMovie()  {
        let fetchRequest: NSFetchRequest<MoviesList> = MoviesList.fetchRequest()
        
        do{
            film = try context.fetch(fetchRequest)
            self.collectionViewX.reloadData()
        }catch{
            print("Error , Sorry I can not fetch data from local storge")
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionViewX.allowsMultipleSelection = true
        let indexPaths = collectionViewX.indexPathsForVisibleItems
        for indexPath in indexPaths{
            let cell = collectionViewX.cellForItem(at: indexPath) as! WatchListCell
            cell.isInEditing = editing
        }
    }
    
}

extension WatchListVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let width = collectionView.frame.size.width
        let xInets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        return CGSize(width: (width / numberOfColumns) - (xInets + cellSpacing), height:  (width / numberOfColumns) - (xInets + cellSpacing))
    }
}

extension WatchListVC: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return film.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        
        if let movieImgURL = film[indexPath.row].poster{
            cell.posterMovie_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(movieImgURL)"), placeholderImage: UIImage(named: "10"))
        }else{
            print("error")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing{
            trash?.isEnabled = false
            
        }else{
            trash?.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        trash?.isEnabled = false
    }
    
}
