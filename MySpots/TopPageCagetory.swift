
import UIKit
import Firebase

class ToppageCategory: NSObject {
    
    var name:String?
    var folders:[Folder] = []
    


//        self.ref.child("list").childByAutoId().setValue(folder1.folderName)

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


