//
//  imageCell.swift
//  SplishSplash
//
//  Created by Henry Jones on 12/26/18.
//  Copyright © 2018 Henry Jones. All rights reserved.
//

import UIKit
//import SDWebImage

class ImageCell: UITableViewCell {

    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var imageSavedLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blur.effect = nil
        blur.alpha = 0.7
    }
    
}

