//
//  FullImageViewTableViewCell.swift
//  SplishSplash
//
//  Created by Henry Jones on 1/6/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class FullImageCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var splashImageView: UIImageView!
    weak var delegate : FullImageCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addLongPressRecognizer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return splashImageView
    }
    
}

protocol FullImageCellProtocol : AnyObject {
    func downloadImageCell()
    var splashItem: SplashItem? { get }
}
extension FullImageCell {
    func addLongPressRecognizer() {
        self.isUserInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressRecognizer.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPressRecognizer)
        
    }
    
    @objc func longPressed() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Save Image", style: .default , handler:{ (UIAlertAction)in
            self.delegate?.downloadImageCell()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
}
