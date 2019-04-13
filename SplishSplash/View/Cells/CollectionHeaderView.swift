//
//  HeaderView.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/12/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class CollectionHeaderView: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    var collectionElement : SplashCollectionElement?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
        self.selectionStyle = .none
    }
    
    func configureCell(){
        if let collectionElement = collectionElement {
        let firstName = collectionElement.user.firstName
        let lastName = collectionElement.user.lastName ?? ""
        self.authorLabel.text = "By: \(firstName) \(lastName)"
        setAuthorImage(imageURL: collectionElement.user.profileImage.medium)
        }
    }
    
    func setAuthorImage(imageURL: String){
        authorImage.layer.borderWidth = 1
        authorImage.layer.masksToBounds = false
        authorImage.layer.borderColor = #colorLiteral(red: 0.1212944761, green: 0.1292245686, blue: 0.141699791, alpha: 1)
        authorImage.layer.cornerRadius = authorImage.frame.height/2
        authorImage.clipsToBounds = true
        authorImage.sd_setImage(with: URL(string: imageURL))
    }
}
