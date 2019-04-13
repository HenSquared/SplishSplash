//
//  SplashCollectionTableViewController.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/11/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class SplashCollectionTableViewController: UITableViewController {
    var id = 0
    var collectionElement : SplashCollectionElement?
    var splashItems = [SplashItem]()
    var images = [UIImage]()
    var query = ""
    var searchController = UISearchController(searchResultsController: nil)
    let kImageCellIdentifier = "cell"
    var pageNumber = 1
    var cellHeights: [IndexPath : CGFloat] = [:]

    
    override func viewDidLoad() {
        UIView.animate(withDuration: 0.25) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: kImageCellIdentifier)
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forCellReuseIdentifier: "headerCell")
        self.tableView.separatorStyle = .none
        getSplashItemsFromCollectionIdentifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar(){
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnTap = false
        navigationController?.hidesBarsOnSwipe = true
        
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
        self.title = collectionElement?.title
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 70.0
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.searchController = nil
        if let destinationVC = segue.destination as? ImageDetailsViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                if( indexPath.row > 1) {
                    destinationVC.splashItem = splashItems[indexPath.row - 2]
                }
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            return indexPath.row > 1
        }
        return false
    }
    
    @objc func didTapBrowserButton(){
        guard let collectionItem = self.collectionElement else { return }
        if let html = collectionItem.links.html {
            guard let url = URL(string: html) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    @objc func didTapShareButton(){
        guard let collectionItem = self.collectionElement else { return }
        if let html = collectionItem.links.html {
            let shareLink = URLService.buildShareURL(url: URL(string: html)!)
            let activityVC = UIActivityViewController(activityItems: [shareLink], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true, completion: nil)
        }
    }
    
    //MARK: TableViewDelegateMethods
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
            pageNumber += 1
            getSplashItemsFromCollectionIdentifier()
        }
        cellHeights[indexPath] = cell.frame.size.height

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.splashItems.count
    }
    
    //Resize cells based on Image
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1: return UITableView.automaticDimension
            
        default:
            let splashItem = self.splashItems[indexPath.row - 2]
            let cropRatio = CGFloat(splashItem.width) / CGFloat(splashItem.height)
            let height = CGFloat(tableView.frame.width / cropRatio)
            return height
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        switch indexPath.row {
        case 0:
            if description.isEmpty {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? CollectionHeaderView {
                    cell.selectionStyle = .none
                    cell.isUserInteractionEnabled = false;
                    guard let collectionElement = collectionElement else {return cell}
                    cell.collectionElement = collectionElement
                    cell.configureCell()
                    return cell
                }
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as? CollectionDescriptionCell {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                if let description = collectionElement?.description{
                    cell.collectionDescription = description
                }
                cell.setupCell()
                return cell
                }
             
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? CollectionHeaderView {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false;
                guard let collectionElement = collectionElement else {return cell}
                cell.collectionElement = collectionElement
                cell.configureCell()
                return cell
                
            }
        
        default:
            let index = indexPath.row - 2
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ImageCell {
                cell.myImage.sd_setImage(with: URL(string:self.splashItems[index].urls.regular))
                cell.myImage.contentMode = .scaleAspectFit
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let row = editActionsForRowAt.row
        
        let more = UITableViewRowAction(style: .normal, title: "Save") { action, index in
            ImageHelpers.downloadUnsplashImage(splashItem: self.splashItems[row])
            if let cell = tableView.cellForRow(at: editActionsForRowAt) as? ImageCell{
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear , animations: {
                    cell.blur.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    cell.imageSavedLabel.alpha = 1.0
                }, completion: {(finshed: Bool) in
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear , animations: {
                        cell.blur.effect = nil
                        cell.imageSavedLabel.alpha = 0.0
                    }, completion: nil)})
            }
        }
        more.backgroundColor = #colorLiteral(red: 0.1628710926, green: 0.1629292667, blue: 0.18664065, alpha: 1)
        
        return [more]
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Save Image"
    }
    
    //    MARK: Other methods:
    //Clears array of splash items and reloads tableview
    func clearSplashItems(){
        self.splashItems = [SplashItem]()
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    //MARK: fetchDataMethods
    func getSplashItemsFromCollectionIdentifier(){
        let collectionIdentifier = collectionElement?.id ?? 0
        let completionHandler : (([SplashItem]) -> Void) = { (splashItems) in
            for splashItem in splashItems {
                self.splashItems.append(splashItem)
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                
            }
        }
        
        QueryService().getSplashItemsFromCollectionIdentifier(collectionIdentifier: collectionIdentifier, pageNumber: pageNumber, completionHandler: completionHandler)
    }
}
