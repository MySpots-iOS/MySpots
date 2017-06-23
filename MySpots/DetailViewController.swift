//
//  DetailViewController.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-19.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit
import GooglePlaces

class DetailViewController: UIViewController {
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var toggleSaveIcon: UIImageView!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var placeHours: UILabel!
    @IBOutlet weak var placePhone: UILabel!
    @IBOutlet weak var placeWebsite: UILabel!
    
    var placeID: String = ""
    var saved: Bool = false
    fileprivate var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.placeName.textColor = UIColor.mainDarkGreen()
        placesClient = GMSPlacesClient.shared()
        getDetailInformationFromID(self.placeID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDetailInformationFromID(_ placeID: String) {
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            //let test = GMSPlacesOpenNowStatus(rawValue: place.openNowStatus.rawValue)
            
            self.placeName.text = place.name
            self.placeAddress.text = place.formattedAddress
            self.placePhone.text = place.phoneNumber
            self.placeWebsite.text = place.website?.absoluteString
        })
        
        placesClient.lookUpPhotos(forPlaceID: placeID, callback: { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        })
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.placePhoto.image = photo;
                //self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
    
}
