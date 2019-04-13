//
//  CollectionDescriptionCell.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/11/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class CollectionDescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var collectionDescription : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
        self.selectionStyle = .none
    }
    
    func setupCell(){
        descriptionLabel.text = collectionDescription ?? ""
    }

}
