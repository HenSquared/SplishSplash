//
//  SplashDataCell.swift
//  SplishSplash
//
//  Created by Henry Jones on 2/7/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class SplashDataCell: UITableViewCell {
    
    var cellType: CellType = .color
    var splashItem : SplashItem?
    var imageDetails : ImageDetails?
    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        setIconAndLabel()
    }
    
    /// set author image using profile image and add circle over image.
    ///
    /// - Parameter imageURL: profile picture url as a string
    func setAuthorImage(imageURL: String){
        infoIcon.layer.borderWidth = 1
        infoIcon.layer.masksToBounds = false
        infoIcon.layer.borderColor = #colorLiteral(red: 0.1212944761, green: 0.1292245686, blue: 0.141699791, alpha: 1)
        infoIcon.layer.cornerRadius = infoIcon.frame.height/2
        infoIcon.clipsToBounds = true
        infoIcon.sd_setImage(with: URL(string: imageURL))
    }
    
    func setIconAndLabel(){
        if let splashItem = splashItem {
            switch cellType {
            case .preview:
                infoLabel.text =  "Preview on home screen"
                infoIcon.image = UIImage(named: "wallpaper-white")
            case .user:
                infoLabel.text = "By \(splashItem.user.name) on Unsplash"
                setAuthorImage(imageURL: (splashItem.user.profileImage.small))
            case .date:
                let dateString = splashItem.updatedAt.toString()
                infoLabel.text = "\(dateString)"
                infoIcon.image = UIImage(named: "calendar-white")
            case .likes:
                infoIcon.image = UIImage(named:"heart-white")
                infoLabel.text = "\(splashItem.likes) Likes"
            case .downloads:
                var downloadText = "\(imageDetails?.downloads ?? 0) Download"
                if imageDetails?.downloads ?? 0 != 1 {
                    downloadText.append("s")
                }
                infoLabel.text = downloadText
                 infoIcon.image = UIImage(named:"share-white")
            case .color:
                infoLabel.text = "\(splashItem.color)"
                infoIcon.image = UIImage(named:"color-white")
            }
        }
    }
}

extension Date {
    func toString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self)
    }

}

enum CellType {
    case preview
    case user
    case date
    case likes
    case downloads
    case color
}
