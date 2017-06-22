//
//  FireBaseController.swift
//  MySpots
//
//  Created by ayako_sayama on 2017-06-21.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import UIKit
import Firebase

class FirebaseController {
    
    let ref = Database.database().reference()
    let nc = NotificationCenter.default
    var mySpots: ToppageCategory = ToppageCategory()
    
    init() {
        firstInit()
    }
    
    func firstInit() {
        mySpots.name = "My Spots"
        
        self.ref.child("MySpotsFolder").observeSingleEvent(of: .value, with: { (snapshot) in
            for folder in snapshot.children {
                if let snap = folder as? DataSnapshot {
                    let folder = self.mySpots.makeFolder(folder: snap)
                    self.mySpots.folders.append(folder)
                }
            }
            self.nc.post(name: Notification.Name(rawValue:"MyNotification"), object: nil)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
//    func fetchingMySpots(completed: @escaping (ToppageCategory) -> Void){
//        
//        
//        let ref = Database.database().reference()
//        let mySpotsCat = ToppageCategory()
//        mySpotsCat.name = "My Spots"
//        
//        
//        ref.child("MySpotsFolder").observe(.value, with: { (snapshot) in
//            
//            for folder in snapshot.children {
//                
//                print((folder as! DataSnapshot).childSnapshot(forPath: "category"))
//                if let snp = folder as? DataSnapshot{
//                    let fld = self.makeFolder(folder: snp)
//                    
//                    
//                    print("Folder made!: \(fld.folderName ?? "fail folder make")")
//                    print("folder: \(mySpotsCat.folders.count)")
//                    
//                    mySpotsCat.folders.append(fld)
//                    
//                }
//            }
//            
//            completed(mySpotsCat)
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
//    }

    
    
   func getMySpots(mySpotsCat:ToppageCategory){
        
        mySpotsCat.name = "My Spots"
        
        let ref = Database.database().reference()
        
        //-------Bring Data from database-----
        
//        ref.child("MySpotsFolder").observe(.value, with: { (snapshot) in
//            
//            for folder in snapshot.children {
//                
//                print((folder as! DataSnapshot).childSnapshot(forPath: "category"))
//                if folder is DataSnapshot{
//                    //let fld = self.makeFolder(folder: folder as! DataSnapshot)
//                    
//
//                    print("Folder made!: \(fld.folderName ?? "fail folder make")")
//                    print("folder: \(mySpotsCat.folders.count)")
//                    
//                    mySpotsCat.folders.append(fld)
//                    
//                }
//            }
//            
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
        
        //        let folder1 = Folder()
        //        folder1.folderName =  "Cafes"
        //        folder1.category = "Food"
        //        folder1.imageName = "cafe1"
        //        folder1.spotsNum = 10
        //
        //        let folder2 = Folder()
        //        folder2.folderName = "SuperMaret"
        //        folder2.category = "Food"
        //        folder2.imageName = "cafe2"
        //        folder2.spotsNum = 4
        //
        //        mySpotfolders.append(folder1)
        //        mySpotfolders.append(folder2)
        //        mySpotsCat.folders = mySpotfolders
        //
        //        print("folderCount: \(mySpotsCat.folders.count)")
        
    }
    
    
    //2. Cateogory2
    
//    func getExploreSpots(exploreCat:ToppageCategory){
//        
//        exploreCat.name = "Expore"
//        
//        var exploreFolders = [Folder]()
//        
//        let exploreFolder1 = Folder()
//        exploreFolder1.folderName = "Hiking Area"
//        exploreFolder1.category = "Outdoor"
//        exploreFolder1.imageName = "hiking1"
//        exploreFolder1.spotsNum = 8
//        
//        exploreFolders.append(exploreFolder1)
//        
//        exploreCat.folders = exploreFolders
//        
//        
//    }    
}
