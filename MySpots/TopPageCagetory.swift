
import UIKit
import Firebase

class ToppageCategory: NSObject {
    
    var name:String?
    var folders:[Folder] = []
    
    func makeFolder(folder:DataSnapshot) -> Folder {
        
        let newFolder = Folder()
        
        //print("make folder: \(folder.value ?? "no value")")
        
        let value = folder.value as? NSDictionary
        
        if let category = value?["category"] {
            newFolder.category = category as? String
        }
        
        if let folderName = value?["folderName"] {
            newFolder.folderName = folderName as? String
        }
        
        if let imageName = value?["imageName"] {
            newFolder.imageName = imageName as? String
        }
        
        if let spotsNum = value?["spotsNum"] {
            newFolder.spotsNum = spotsNum as? Int
        }
        
        return newFolder
    }




}

class Folder: NSObject {
    var id: NSNumber?
    var folderName: String?
    var category: String?
    var imageName: String?
    var spotsNum: Int?
}


//class Spot:NSObject{
//    
//    var folderID:NSNumber?
//    var spotName:String?
//    var latitude:Double?
//    var longitude:Double?
//    
//}


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


