//
//  SplashyViewController.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/9/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import UIKit

class SplashyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var segmentViewControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var splashItems = [SplashItem]()
    var splashCollections = [SplashCollectionElement]()
    var images = [UIImage]()
    var query = ""
    var searchController = UISearchController(searchResultsController: nil)
    let kImageCellIdentifier = "cell"
    let kCardCellIdentifier = "cardCell"
    var pageNumber = 1
    var lastContentOffset: CGFloat = 0
    var cellHeights: [IndexPath : CGFloat] = [:]
    let kSaveImageText = "Save Image"
    
    var selectedTab: Tabs {
        switch segmentViewControl.selectedSegmentIndex {
        case 1: return .collections
        default: return .new
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSplashItems()
        setupTableView()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        setupSegmentControl()
    }
   
    //MARK: Setup helpers
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: kImageCellIdentifier)
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: kCardCellIdentifier)
        self.tableView.separatorStyle = .none
    }
    
    func setupSegmentControl(){
        segmentViewControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    //Can likely be moved out of this class.
    func setupNavBar(){
        navigationController?.isNavigationBarHidden = false
        searchController.searchBar.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)]
            switch selectedTab {
            case .collections: textfield.placeholder = "Search Collections"
            case .new: textfield.placeholder = "Search Images"
            }
            if let backgroundview = textfield.subviews.first {
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
            
            navigationItem.hidesSearchBarWhenScrolling = false
            self.searchController.searchBar.delegate = self
            navigationItem.searchController = searchController
        }
    }
    
    
    //MARK: Search Bar Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        clearSplashItems()
        segmentViewControl.selectedSegmentIndex = 2
        if let searchText = searchBar.text {
            if searchText == "" {
                getSplashItems()
            }
            query = searchText
            getSplashItems(query:query)
        }
    }
    
    //MARK ScrollView Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.25, animations: {
                self.navigationController?.isNavigationBarHidden = true
            })
            
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.25, animations: {
                self.navigationController?.isNavigationBarHidden = false
            })
        } else {
            // do nothing, didn't move
            
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.becomeFirstResponder()
        self.tableView.becomeFirstResponder()
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.searchController = nil
        switch selectedTab {
        case .collections: if let destinationVC = segue.destination as? SplashCollectionTableViewController{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destinationVC.collectionElement = (splashCollections[indexPath.row])
            }
            }
        default:
            if let destinationVC = segue.destination as? ImageDetailsViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    destinationVC.splashItem = splashItems[indexPath.row]
                }
            }
        }
    }
    
    //MARK: TableViewDelegateMethods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedTab {
        case .collections: performSegue(withIdentifier: "toCollections", sender: self)
        default: performSegue(withIdentifier: "detailViewSegue", sender: self)

        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //disable editing collection items
        return selectedTab != .collections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedTab {
        case .collections:
            return self.splashCollections.count
        default:
            return self.splashItems.count
        }
    }
    
    //Resize cells based on Image
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collectionCellHeight = 300
        switch selectedTab {
        case .collections:
            return CGFloat(collectionCellHeight)
        default:
            let splashItem = self.splashItems[indexPath.row]
            let cropRatio = CGFloat(splashItem.width) / CGFloat(splashItem.height)
            let height = CGFloat(tableView.frame.width / cropRatio)
            return height
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 5) {
            pageNumber += 1
            switch selectedTab {
            case .collections: getMoreItems(type: .collections)
            case .new: getMoreItems(type: query.isEmpty ? .new : .search)
            }
        }
        cellHeights[indexPath] = cell.frame.size.height

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedTab{
        case .collections:
            let collectionItem = splashCollections[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier:
                kCardCellIdentifier) as? CardCell {
                cell.collectionItem = collectionItem
                cell.setupCell()
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: kImageCellIdentifier) as? ImageCell {
                cell.myImage.sd_setImage(with: URL(string:self.splashItems[indexPath.row].urls.regular))
                cell.myImage.contentMode = .scaleAspectFit
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 70.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let animationDuration = 0.5
        
        
        switch selectedTab {
        case .collections: return nil
        default:
            let row = editActionsForRowAt.row
            
            let more = UITableViewRowAction(style: .normal, title: "Save") { action, index in
                ImageHelpers.downloadUnsplashImage(splashItem: self.splashItems[row])
                if let cell = tableView.cellForRow(at: editActionsForRowAt) as? ImageCell{
                    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveLinear , animations: {
                        cell.blur.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                        cell.imageSavedLabel.alpha = 1.0
                    }, completion: {(finshed: Bool) in
                        UIView.animate(withDuration: animationDuration, delay: 0.5, options: .curveLinear , animations: {
                            cell.blur.effect = nil
                            cell.imageSavedLabel.alpha = 0.0
                        }, completion: nil)})
                }
            }
            more.backgroundColor = #colorLiteral(red: 0.1628710926, green: 0.1629292667, blue: 0.18664065, alpha: 1)
            
            return [more]
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return kSaveImageText
    }
    
    //    MARK: Other methods:
    //Clears array of splash items and reloads tableview
    func clearSplashItems(){
        pageNumber = 1
        self.splashItems = [SplashItem]()
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    @objc func segmentChanged(){
        setupNavBar()
        clearSplashItems()
        query = ""
        switch selectedTab {
        case .new:
            getSplashItems()
        case .collections:
            getFeaturedCollections()
        }
    }
    
    //MARK: fetchDataMethods
    func getMoreItems(type:SplashDataType){
        switch type {
        case .collections:
            getFeaturedCollections()
        case .new:
            getSplashItems()
        case .search:
            getSplashItems(query: query)
        }
    }
    
    func getFeaturedCollections(){
        let completionHandler : (([SplashCollectionElement]) -> Void) = { (splashCollections) in
            for splashCollection in splashCollections {
                self.splashCollections.append(splashCollection)
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
        QueryService().requestNewCollections(perPage: 10, pageNumber: pageNumber, completionHandler: completionHandler)
    }
    
    func getSplashItems(query: String = ""){
        let completionHandler : (([SplashItem]) -> Void) = { (splashItems) in
            for splashItem in splashItems {
                self.splashItems.append(splashItem)
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
        if (query.isEmpty){
            QueryService().requestNewPhotos(perPage: 10,pageNumber: pageNumber, completionHandler: completionHandler)
        } else {
            QueryService().requestNewPhotos(query: query, perPage: 10, pageNumber: pageNumber, completionHandler: completionHandler)
        }
    }
}

enum Tabs {
    case new
    case collections
}

enum SplashDataType {
    case collections
    case new
    case search
}
