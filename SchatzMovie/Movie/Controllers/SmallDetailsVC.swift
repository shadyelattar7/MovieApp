//
//  SmallDetailsVC.swift
//  Movie
//
//  Created by Elattar on 8/23/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import MarqueeLabel
import SDWebImage

class SmallDetailsVC: UIViewController {

    var movieTitle: String?
    var poster: String?
    var backGround: String?
    var overView: String?
    var rate: Double?
    
    @IBOutlet weak var poster_img: UIImageView!
    @IBOutlet weak var movieTitle_lbl: MarqueeLabel!
    @IBOutlet weak var rate_lbl: UILabel!
    @IBOutlet weak var overView_txtv: UITextView!
    @IBOutlet weak var background_img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let backgroundMovie = backGround{
            background_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(backgroundMovie)"), placeholderImage: UIImage(named: "10"))
        }
        
        if let posterMovie = poster{
            poster_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "10"))
        }
        
        movieTitle_lbl.text = movieTitle
        overView_txtv.text = overView
        rate_lbl.text = "\(rate!)"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remind me", style: .plain, target: self, action: #selector(remindMe_btn))
       
    }
    
    @objc func remindMe_btn()  {
    
        let reminder = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReminderVC") as!
            ReminderVC
        
        reminder.titleMovie = movieTitle!
        reminder.poster = poster!
        
        navigationController?.pushViewController(reminder, animated: true)
    
    }
    
  

}
