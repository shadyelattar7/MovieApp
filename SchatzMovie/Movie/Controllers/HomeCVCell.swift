//
//  HomeCVCell.swift
//  Movie
//
//  Created by Elattar on 8/21/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit
import Gemini

class HomeCVCell: GeminiCell {
    
    @IBOutlet weak var movieRate_lbl: UILabel!
    @IBOutlet weak var movieTitle_lbl: UILabel!
    @IBOutlet weak var moviePoster_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moviePoster_img.layer.cornerRadius = 10.0
        moviePoster_img.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
}
