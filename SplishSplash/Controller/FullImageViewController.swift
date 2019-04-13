//
//  FullImageViewController.swift
//  SplishSplash
//
//  Created by Henry Jones on 12/28/18.
//  Copyright © 2018 Henry Jones. All rights reserved.
//

import UIKit
//import SDWebImage
class FullImageViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var splashItem : SplashItem?
    var shouldDisplayWallpaperPreview = false
    
    override var prefersStatusBarHidden: Bool {
        return shouldDisplayWallpaperPreview
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var transparentIconsImageView: UIImageView!
    
    
    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        transparentIconsImageView.isHidden = !shouldDisplayWallpaperPreview
        setupWallpaperPreview()
        setupScrollView()
        setupGestures()
        if let splashItem = splashItem {
            detailedImageView.sd_setImage(with: URL(string: splashItem.urls.full
            ))
        }
        self.navigationController?.isNavigationBarHidden = true
        detailedImageView.contentMode = shouldDisplayWallpaperPreview ? .scaleAspectFill : .scaleAspectFit
    }
    
    func setupGestures(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func setupWallpaperPreview(){
        transparentIconsImageView.image = UIDevice.current.type.iconsImage
    }

    
    @objc func handleGesture(){
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer){
        
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer){
        if (!shouldDisplayWallpaperPreview){
            if scrollView.zoomScale == 1 {
                scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: gesture.location(in: gesture.view)), animated: true)
            } else {
                scrollView.setZoomScale(1, animated: true)
            }
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = detailedImageView.frame.size.height / scale
        zoomRect.size.width  = detailedImageView.frame.size.width  / scale
        let newCenter = scrollView.convert(center, from: detailedImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Disable or enable zooming.
        let shouldEnableZoom = !shouldDisplayWallpaperPreview
        if (shouldDisplayWallpaperPreview){
            AppDelegate.AppUtility.lockOrientation(.portrait)
        }
        scrollView.pinchGestureRecognizer?.isEnabled = shouldEnableZoom
        scrollView.panGestureRecognizer.isEnabled = shouldEnableZoom
    }
    
    func setupScrollView(){
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tapGR)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailedImageView
    }
    

}
