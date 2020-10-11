//
//  SearchTVCell.swift
//  Movie
//
//  Created by Elattar on 8/22/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit

class SearchTVCell: UITableViewCell {

    @IBOutlet weak var movieDate_lbl: UILabel!
    @IBOutlet weak var movieTitle_lbl: UILabel!
    @IBOutlet weak var poster_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
