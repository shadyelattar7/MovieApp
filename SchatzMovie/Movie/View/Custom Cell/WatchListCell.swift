//
//  WatchListCell.swift
//  Movie
//
//  Created by Elattar on 9/10/19.
//  Copyright © 2019 Elattar. All rights reserved.
//

import UIKit

class WatchListCell: UICollectionViewCell {

    @IBOutlet weak var chackMark_lbl: UILabel!
    @IBOutlet weak var posterMovie_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chackMark_lbl.layer.cornerRadius = 9
    }
    
    var isInEditing: Bool = false {
        didSet{
            chackMark_lbl.isHidden = !isInEditing
        }
    }

    override var isSelected: Bool{
        didSet{
            if isInEditing{
                
              let alert = UIColor.red.cgColor
              chackMark_lbl.text = isSelected ? "✓" : ""
              chackMark_lbl.layer.backgroundColor  = isSelected ? alert : .none
            }
        }
    }
}
