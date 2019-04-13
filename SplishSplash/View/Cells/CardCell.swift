//
//  CardCell.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/9/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardSubtitleLabel: UILabel!
    
    var collectionItem : SplashCollectionElement?
    
    func setupCell(){
        selectionStyle = .none
        if let collectionItem = collectionItem {
            cardImageView.contentMode = .scaleAspectFill
            cardImageView.clipsToBounds = true
            if let cover = collectionItem.coverPhoto {
                cardImageView.sd_setImage(with: URL(string:cover.urls.small)!)
            }
            cardTitleLabel.text = collectionItem.title
            cardSubtitleLabel.text = "\(collectionItem.totalPhotos) Photos"
        }
        
    }
    
}
