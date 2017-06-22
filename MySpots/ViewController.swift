//
//  ViewController.swift
//  MySpots
//
//  Created by ayako_sayama on 2017-06-20.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import UIKit

class TopPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellid = "cellid"
    let nc = NotificationCenter.default
    
    var topPageCategories: [ToppageCategory]? = []
    var fbController = FirebaseController()
    
    //Override UICollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nc.addObserver(self, selector: #selector(self.initCompleted(notification:)), name: Notification.Name("FirebaseNotification"), object: nil)
        
        //fbController.getExploreSpots(exploreCat:exploreCat)
        
        
        //self.topPageCategories?.append(mySpotsCat)
        //self.topPageCategories?.append(exploreCat)
        

        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self,forCellWithReuseIdentifier: self.cellid)
        view.addSubview(collectionView!)
    }
    
    func initCompleted(notification: Notification?) {
        self.topPageCategories?.append(fbController.mySpots)
        // no longer to hold the observer
        self.nc.removeObserver(self)
        refreshCollectionView()
    }
    
    /**
     If data changed, it must be called to update collection view
    */
    func refreshCollectionView() {
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! CategoryCell
        
        
        //for each cell, assign it to a ToppageCategory Class
        cell.topPageCategory = topPageCategories?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = topPageCategories?.count {
            return count
        } else {
            return 0
        }
    }
    
    
    //Override FlowlayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    
}


