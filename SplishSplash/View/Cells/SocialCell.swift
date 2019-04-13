//
//  DownloadCell.swift
//  
//
//  Created by Henry Jones on 1/13/19.
//

import UIKit

class SocialCell: UITableViewCell{
    
    weak var delegate: DownloadImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func handleDownloadTap(_ sender: Any) {
        delegate!.downloadImage()
    }
    
    
}

protocol DownloadImageDelegate: AnyObject {
    func downloadImage()
}

protocol ShareImageDelegate: AnyObject {
    func shareImage()
}
