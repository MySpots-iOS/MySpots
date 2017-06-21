
import UIKit
import Firebase

class ToppageCategory: NSObject {
    
    var name:String?
    var folders:[Folder] = []
    
//    var handle:DatabaseHandle?
    


    static func getMySpots() -> ToppageCategory {
        
        let mySpotsCat = ToppageCategory()
        mySpotsCat.name = "My Spots"
        
//        var mySpotfolders = [Folder]()
//        let ref = Database.database().reference()
//        
//        //-------Bring Data from database-----
//        
//        
//        ref.observe(.childAdded, with: { (snapshot) in
//            
//            for folder in snapshot.children{
//                
////                print((folder as! DataSnapshot).childSnapshot(forPath: "category"))
//                print(folder)
//                
//                if let snp = folder as? DataSnapshot{
//                    let fld = makeFolder(folder: snp)
//                    mySpotfolders.append(fld)
//                    
//                    print("folder: \(mySpotfolders.count)")
//                }
//            }
//            
//            mySpotsCat.folders = mySpotfolders
//
//        })

//        ref.child("MySpotsFolder").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            for folder in snapshot.children{
//                
//                print((folder as! DataSnapshot).childSnapshot(forPath: "category"))
//                if let snp = folder as? DataSnapshot{
//                    let fld = makeFolder(folder: snp)
//                    mySpotfolders.append(fld)
//                    
//                    print("folder: \(mySpotfolders.count)")
//                }
//            }
//            
//            mySpotsCat.folders = mySpotfolders
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }

        
        print("folderCount: \(mySpotsCat.folders.count)")


        return mySpotsCat

    }

    
//        let folder1 = Folder()
//        folder1.folderName = "Cafes"
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
//        folders.append(folder1)
//        folders.append(folder2)
        
//        self.ref.child("list").childByAutoId().setValue(folder1.folderName)

        
    //2. Cateogory2
    
    static func getExploreSpots() -> ToppageCategory {
        
        
        let exploreCat = ToppageCategory()
        exploreCat.name = "Expore"
        
        var exploreFolders = [Folder]()
        
        let exploreFolder1 = Folder()
        exploreFolder1.folderName = "Hiking Area"
        exploreFolder1.category = "Outdoor"
        exploreFolder1.imageName = "hiking1"
        exploreFolder1.spotsNum = 8
        
        exploreFolders.append(exploreFolder1)
        
        exploreCat.folders = exploreFolders
        
        return exploreCat
    }
    
}

//func makeFolder(folder:DataSnapshot) -> Folder{
//    
//    let newFolder = Folder()
//    
//    print("make folder")
//    
//    let value = folder.value as? NSDictionary
//    
//    if let category = value?["category"]{
//        newFolder.category = category as? String
//    }
//    
//    if let folderName = value?["folderName"]{
//        newFolder.folderName = folderName as? String
//    }
//    
//    if let imageName = value?["imageName"]{
//        newFolder.imageName = imageName as? String
//    }
//    
//    if let spotsNum = value?["spotsNum"]{
//        newFolder.spotsNum = spotsNum as? Int
//    }
//    
//    return newFolder
//}


class Folder: NSObject {
    
    var id: NSNumber?
    var folderName: String?
    var category: String?
    var imageName: String?
    var spotsNum: Int?
}



class Spot:NSObject{
    
    var folderID:NSNumber?
    var spotName:String?
    var latitude:Double?
    var longitude:Double?
    
}


//extension Spot{
//
//    class MySpot:NSObject{
//        var folderID:NSNumber?
//        var spotName:String?
//        var latitude:Double?
//        var longitude:Double?
//    }
//
//    class ExploreSpot:NSObject{
//        var folderID:NSNumber?
//        var spotName:String?
//        var latitude:Double?
//        var longitude:Double?
//    }
//}


