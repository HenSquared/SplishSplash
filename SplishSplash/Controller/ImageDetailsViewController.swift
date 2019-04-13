//
//  ImageDetailsViewController.swift
//  SplishSplash
//
//  Created by Henry Jones on 12/31/18.
//  Copyright © 2018 Henry Jones. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UITableViewController, UIGestureRecognizerDelegate, FullImageCellProtocol {
   
    
    var splashItem : SplashItem?
    var imageDetails : ImageDetails?
    var splashDataPropertyNames = ["Preview","Author","Date","Likes","Downloads","Color"]
    let kFullImageCellIdentifier = "fullImageCell"
    let kSocialStatsCellIdentifier = "socialStatsCell"
    let kDownloadImageCellIdentifier = "downloadCell"
    let kSplashDataCellIdentifier = "splashDataCell"
    let kOpenInDefaultBrowserMessage = "This will open in your default browser. Would you like to continue?"
    let kSocialStatsCellHeight = 80.0
    var propertyValues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageDetails()
        setupTableView()
        if let splashItem = splashItem{
            setPropertyValues(splashItem: splashItem)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "FullImageCell", bundle: nil), forCellReuseIdentifier: kFullImageCellIdentifier)
        tableView.register(UINib(nibName: "DownloadCell", bundle: nil), forCellReuseIdentifier: kDownloadImageCellIdentifier)
        tableView.register(UINib(nibName: "SocialStatsCell", bundle: nil), forCellReuseIdentifier: kSocialStatsCellIdentifier)
        tableView.register(UINib(nibName: "SplashDataCell", bundle: nil), forCellReuseIdentifier: kSplashDataCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    func setupNavigationBar(){
        let shareImage    = UIImage(named: "share-white")!
        let browserImage  = UIImage(named: "browser-white")!
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let shareButton : UIButton = UIButton.init(type: .custom)
        shareButton.setImage(shareImage, for: .normal)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        shareButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareButtonItem = UIBarButtonItem(customView: shareButton)
        
        let browserButton : UIButton = UIButton.init(type: .custom)
        browserButton.setImage(browserImage, for: .normal)
        browserButton.addTarget(self, action: #selector(didTapBrowserButton), for: .touchUpInside)
        browserButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let browserButtonItem = UIBarButtonItem(customView: browserButton)
        navigationItem.rightBarButtonItems = [shareButtonItem, browserButtonItem]

    }
    
    func setPropertyValues(splashItem: SplashItem){
        propertyValues.append(splashItem.user.name)
        propertyValues.append(splashItem.description ?? "--")
        propertyValues.append("\(splashItem.height)x\(splashItem.width)")
        propertyValues.append("\(splashItem.likes)")
        propertyValues.append(splashItem.color)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "showFullImageView", sender: self)
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "showFullImageView", sender: self)
        }
        if indexPath.row == 2 {
            
            let userURL = URL(string: "https://unsplash.com/@" + (splashItem?.user.username)!)
            let alertController = UIAlertController(title: "Leaving Application", message: kOpenInDefaultBrowserMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                UIAlertAction in
                UIApplication.shared.open(userURL!)
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let splashItem = splashItem else { return UITableView.automaticDimension }
        if (indexPath.row == 0){
            let cropRatio = CGFloat(splashItem.width) / CGFloat(splashItem.height)
            let height = CGFloat(tableView.frame.width / cropRatio)
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splashDataPropertyNames.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.1628710926, green: 0.1629292667, blue: 0.18664065, alpha: 1)
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: kFullImageCellIdentifier) as? FullImageCell {
                cell.delegate = self
                guard let splashItem = self.splashItem else { return cell}
                cell.splashImageView.sd_setImage(with: URL(string: splashItem.urls.regular))
                cell.splashImageView.contentMode = .scaleAspectFit
                cell.isUserInteractionEnabled = true;
                let clearView = UIView()
                clearView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = clearView
                return cell
            }
        }
        
        // Start Data Cells
        if (indexPath.row > 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "splashDataCell", for: indexPath) as! SplashDataCell
            cell.splashItem = splashItem
            cell.imageDetails = imageDetails
            switch indexPath.row {
            case 1: cell.cellType = .preview
            case 2: cell.cellType = .user
            case 3: cell.cellType = .date
            case 4: cell.cellType = .likes
            case 5: cell.cellType = .downloads
            case 6: cell.cellType = .color
            default:
                return cell
            }
            return cell
        }
        return UITableViewCell()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FullImageViewController{
            if self.tableView.indexPathForSelectedRow?.row == 1 {
                destinationVC.splashItem = splashItem
                destinationVC.shouldDisplayWallpaperPreview = true
            } else {
                destinationVC.splashItem = splashItem
            }
            
        }
    }
    
    @objc func didTapShareButton(){
        if let splashItem = splashItem {
            let link = URLService.buildShareURL(url: URL(string: splashItem.links.html)!)
            let activityVC = UIActivityViewController(activityItems: [link], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
        }
    }

@objc func didTapBrowserButton(){
    let alertController = UIAlertController(title: "Leaving Application", message: "This will open in your default browser. Would you like to continue?", preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
        UIAlertAction in
        if let splashItem = self.splashItem {
            UIApplication.shared.open(URL(string: splashItem.links.html)!)
        }
    }
    let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
        UIAlertAction in
        alertController.dismiss(animated: true, completion: nil)
    }
    
    // Add the actions
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    
    // Present the controller
    self.present(alertController, animated: true, completion: nil)
    
}
    
    func shareImage(){
        if let splashItem = splashItem {
            if let data = try? Data(contentsOf: URL(string: splashItem.links.downloadLocation)!) {
                if let image = UIImage(data: data) {
                    let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                    activityVC.popoverPresentationController?.sourceView = self.view
                    self.present(activityVC,animated: true, completion: nil)
                }
            }
        }
    }
    
    func downloadImageCell() {
        if let splashItem = self.splashItem {
            ImageHelpers.downloadUnsplashImage(splashItem: splashItem)
        }
    }
    
    func getImageDetails(){
        guard let splashItemId = splashItem?.id else { return  }
        QueryService().getImageDetails(splashItemId: splashItemId, completionHandler: {
            (imageDetails) in self.imageDetails = imageDetails
        })
    }
    
    func downloadImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Save Image", style: .default , handler:{ (UIAlertAction)in
//            self.saveImageToDevice()
            guard let splashItem = self.splashItem else {return}
              ImageHelpers.downloadUnsplashImage(splashItem: splashItem)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: nil)
       
        }
    func saveImageToDevice(){
//        DispatchQueue.global().async { [weak self] in
            if let splashItem = self.splashItem {
                ImageHelpers.downloadUnsplashImage(splashItem: splashItem)
//                if let data = try? Data(contentsOf: URL(string: splashItem.links.downloadLocation)!) {
//                    if let image = UIImage(data: data) {
//                        CustomPhotoAlbum().save(image:image)
//                    }
//                }
            }
//        }
    }
}

