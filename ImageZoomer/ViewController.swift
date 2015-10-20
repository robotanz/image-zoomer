//
//  ViewController.swift
//  ImageZoomer
//
//  Created by Thomas Jgenti on 18/10/2015.
//  Copyright © 2015 Thomas Jgenti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageFrame: CGRect!
    
    var shouldInit: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shouldInit = true
    }
    
    override func viewDidLayoutSubviews() {
        
        if(shouldInit == nil) {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let image = UIImage(named: "Iceland.jpg")!
            imageView.image = image
            
            
            var imageSize = image.size
            let screenScale = UIScreen.mainScreen().scale
            imageSize.width = imageSize.width / screenScale
            imageSize.height = imageSize.height / screenScale
            
            imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size:imageSize)
            scrollView.contentSize = imageSize
            
            shouldInit = false;

            scrollView.minimumZoomScale = 1
            scrollView.maximumZoomScale = 3
            scrollView.zoomScale = 1
            
            //scrollView.zoomToRect(imageFrame, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapAction(sender: UITapGestureRecognizer) {
        if(sender.state == .Ended) {
            scrollView.zoomToRect(imageFrame, animated: true)
        }
    }
    
    // MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(view: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView,
        withView view: UIView?,
        atScale scale: CGFloat) {
            
            //print("Scale: ", scale)
            
            centerScrollViewContents()
    }

    func centerScrollViewContents() {
        // This method centers the scroll view contents also used on did zoom
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if (contentsFrame.size.width < boundsSize.width) {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if (contentsFrame.size.height < boundsSize.height) {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame;
    }

}

