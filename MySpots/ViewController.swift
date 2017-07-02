//
//  ViewController.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-22.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    private let nc = NotificationCenter.default
//    private let ncName = NotificationCenter.Name("FirebaseNotification")
    
    var topPageCategories: [ToppageCategory]? = []
    var fbController:FirebaseController?
    
    //Override UICollectionViewController
    var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init firebase
        fbController = FirebaseController()
        
        //Set observer to watch database init when it finished
        nc.addObserver(self, selector: #selector(self.initCompleted(notification:)), name: Notification.Name("FirebaseNotification"), object: nil)
        
        initCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func initCompleted(notification: Notification?) {
        print("completed")
        //self.topPageCategories?.append(fbController.mySpots)
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
    
    

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! CategoryCell
        
}

extension ViewController {
    // init of collection view
    func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width:100, height:172)
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 14, 15, 14)
        flowLayout.headerReferenceSize = CGSize(width:100, height:50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Section")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    // return number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // set action when user tapped the cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let pageViewController = storyboard.instantiateViewController(withIdentifier: "map") as! UINavigationController
        let view = pageViewController.topViewController as! MapViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section) {
            case 0:
                // return MySpots number of folders
                if (fbController?.mySpots.folders.count)! > 0 {
                    return fbController!.mySpots.folders.count
                } else {
                    return 0
                }
            case 1:
                // return Explore number of folders(WIP)
                return 2
            default:
                //Nil or Error
                return 0
        }
    }
    
    // set value of section
    // especially, header section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            case UICollectionElementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath)
            
                headerView.backgroundColor = UIColor.gray
//                let textLabel = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.bounds.width, height: 50))
//                switch indexPath.section {
//                case 0:
//                    textLabel.text = "My Spots"
//                case 1:
//                    textLabel.text = "Explore"
//                default:
//                    break
//                }
                
                //headerView.addSubview(textLabel)
            
                return headerView
            
        //case UICollectionElementKindSectionFooter: break
            // nothing to do
            default:
                assert(false, "Unexpected element kind")
        }
    }
    
    // set value of each cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath as IndexPath) as! CustomCollectionViewCell
        
        switch(indexPath.section){
            case 0:
                //cell.backgroundColor = UIColor.red
                //cell.textLabel?.text = "0"
                //cell.setSpotFolder()
                if (fbController?.mySpots.folders.count)! > 0 {
                    cell.setSpotFolder(fbController?.mySpots.folders[indexPath.row])
                }
            case 1:
                //cell.backgroundColor = UIColor.green
                //cell.textLabel?.text = "1"
                break
            
            default:
                print("section error")
                cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
}
