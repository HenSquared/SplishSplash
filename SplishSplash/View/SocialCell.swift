//
//  DownloadCell.swift
//  
//
//  Created by Henry Jones on 1/13/19.
//

import UIKit

class SocialCell: UITableViewCell{
    
    weak var delegate: SocialCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleDownloadTap(_ sender: Any) {
        delegate!.downloadImage()
    }
    
    @IBAction func handleShareTap(_ sender: Any) {
        delegate!.shareImage()
    }
    
}

protocol SocialCellDelegate: AnyObject {
    func downloadImage()
    func shareImage()
}
