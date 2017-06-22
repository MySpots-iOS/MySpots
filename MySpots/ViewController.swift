//
//  ViewController.swift
//  MySpots
//
//  Created by ayako_sayama on 2017-06-20.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import UIKit

class TopPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    private let cellid = "cellid"
    let mySpotsCat = ToppageCategory()
    
    var topPageCategories: [ToppageCategory]?

    
    //Override UICollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        topPageCategories = []
        asyncFetchData()
        
//        mySpotsCat.fetchingMySpots { (mySpotsCat) -> Void in
//            print("success!!")
//            print(mySpotsCat.folders)
//        }
    
//        let mySpotsCat = ToppageCategory.fetchingMySpots(completionHandler: (ToppageCategory) -> Void)
        
        print("getting my spots...")
        
//        let topcategory = ToppageCategory.fetchingMySpots { (folders) in
//             print(folders)
//        }
//        
        
        
        let exploreCat = ToppageCategory.getExploreSpots()
        
        self.topPageCategories?.append(mySpotsCat)
        self.topPageCategories?.append(exploreCat)
        

        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self,forCellWithReuseIdentifier: self.cellid)
        view.addSubview(collectionView!)
    }
    
    func asyncFetchData() {
        DispatchQueue(label: "test.queue").async {
            self.mySpotsCat.firstInit()
            
            DispatchQueue.main.async {
                print("check")
                self.collectionView?.reloadData()
            }
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! CategoryCell
        
        
        //for each cell, assign it to a ToppageCategory Class
        cell.topPageCategory = topPageCategories?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = topPageCategories?.count{
            return count
        } else{
            return 0
        }
    }
    
    
    //Override FlowlayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    
}


