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
    let firebasePath: String = "MySpotsFolder"
    var mySpots: ToppageCategory = ToppageCategory()
    
    init() {
        firstInit()
    }
    
    func firstInit() {
        mySpots.name = "My Spots"
        
        
        // How to make a New folder
        
//        //1: generate a unique key to folder
//        let folderRef = ref.child("ExploreFolders").childByAutoId();
//        
//        //2. make a array of folder info
//        let newFolder = ["category": "BARS", "folderName": "JAZZBAR", "imageName":"livehouse1", "spotsNum":8 , "Spots":[]] as [String : Any]
//        
//        //3.put the folder info inside the generated key
//        folderRef.updateChildValues(newFolder)
//        
//        
        
//        self.ref.child("ExploreFolders").child()setValue(folder1.folderName)

        
        self.ref.child(firebasePath).observeSingleEvent(of: .value, with: { (snapshot) in
            for folder in snapshot.children {
                if let snap = folder as? DataSnapshot {
                    let folder = self.mySpots.makeFolder(folder: snap)
                    self.mySpots.folders.append(folder)
                }
            }
            
            
        NotificationCenter.default.post(name: Notification.Name(rawValue:"FirebaseNotification"), object: nil)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
   func getMySpots(mySpotsCat:ToppageCategory){
        
        mySpotsCat.name = "My Spots"
        
        //let ref = Database.database().reference()
        
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
