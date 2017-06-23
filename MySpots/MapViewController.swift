//
//  ViewController.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-15.
//  Copyright © 2017 Michinobu Nishimoto. All rights reserved.
//

import UIKit
import GoogleMaps
//import GooglePlaces
import GooglePlacePicker

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    fileprivate var locationManager = CLLocationManager()
    fileprivate var mapView: GMSMapView!
    fileprivate var placesClient: GMSPlacesClient!
    fileprivate var zoomLevel: Float = 15.0
    
    // A default location to use when location permission is not granted.
    fileprivate let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    fileprivate var placeInformationView: PlaceInformation? = nil
    fileprivate var generalInformation: UIView? = nil
    fileprivate var generalInfoBottomConstraints: [NSLayoutConstraint] = []
    fileprivate var showListView: UITableView!
    fileprivate var showLists: UILabel!
    fileprivate var showListViewHeightConstraints: [NSLayoutConstraint] = []
    fileprivate var flag:Bool = false
    
    //TODO
    // marker variable that stored from database
    var markers: [GMSMarker] = []
    
    // another marker variable is temp
    fileprivate var tempMarker: GMSMarker? = nil
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("Executed: Willmove")
        animateHideView()
        //mapView.clear()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Executed: didtapmarker")
        setGeneralInformation(marker.snippet!, userData: marker.userData!)
        return true
    }
    
    func mapView(_ mapView:GMSMapView, idleAt cameraPosition:GMSCameraPosition) {
        reverseGeocodeCoordinate(cameraPosition.target)
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        // Store GMSGeocoder as an instance variable.
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            guard error == nil else {
                return
            }
            
            //            if let result = response?.firstResult() {
            //                print(result)
            //            }
        }
    }
    
    /**
     Tap event which is not a place from Google Place
     
     - parameters:
     - mapView: Map View
     - coordinate: Tapped loacation coordinate(2D)
     
     */
    func mapView(_ mapView:GMSMapView, didTapAt coordinate:CLLocationCoordinate2D) {
        print("Executed: TapAt CL")
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        tempMarker?.map = nil
        animateHideView()
    }
    
    /**
     Tap event on Google Map
     
     - parameters:
     - mapView: Map View
     - placeID: Place identifier that it is stored Google Places
     - name: Place name
     - location: Place location coordinate(2D)
     
     */
    func mapView(_ mapView:GMSMapView, didTapPOIWithPlaceID placeID:String, name:String, location:CLLocationCoordinate2D) {
        print("Executed: POI")
        print("You tapped at \(location.latitude), \(location.longitude)")
        tempMarker?.map = nil
        tempMarker = makeMarker(position: location, placeID: placeID, color: .black, saved: false)
        setGeneralInformation(placeID, userData: tempMarker?.userData!)
    }
    
    /**
     Set data to the information view
     
     - parameters:
     - placeID: Place identifier
     
     */
    func setGeneralInformation(_ placeID: String, userData: Any?) {
        if let savedFlag = userData as? [String: Bool] {
            if savedFlag["saved"]! == true {
                self.placeInformationView?.setSavedIcon()
                self.placeInformationView?.saved = savedFlag["saved"]!
            } else {
                self.placeInformationView?.setUnSavedIcon()
                self.placeInformationView?.saved = savedFlag["saved"]!
            }
        }
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            
            self.placeInformationView?.setSelectedPlaceName(place.name)
            self.placeInformationView?.setSelectedAddress(place.formattedAddress!)
            self.placeInformationView?.setGooglePlaceID(placeID)
            self.placeInformationView?.setPlaceRate(place.rating)
        })
        animateShowView()
    }

    /**
     Make marker on Google Map
     
     - parameters:
     - position: Location Coordinate(2D)
     - placeID: Place ID
     - color: Marker Color
     
     */
    func makeMarker(position: CLLocationCoordinate2D, placeID: String, color: UIColor, saved: Bool) -> GMSMarker {
        let marker = GMSMarker(position: position)
        marker.snippet = placeID
        marker.icon = GMSMarker.markerImage(with: color)
        marker.map = mapView
        
        // TODO set flag which is stored or not
        if saved == true {
            marker.userData = ["saved": true]
        } else {
            marker.userData = ["saved": false]
        }
        
        
        return marker
    }
    
}

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationInit()
        mapInit()
        
        // TODO load locations function
        
        // TEST DATA
        markers.append(makeMarker(position: CLLocationCoordinate2D.init(latitude: 37.7859022974905, longitude: -122.410837411881), placeID: "ChIJAAAAAAAAAAARembxZUVcNEk", color: .black, saved: true))
        markers.append(makeMarker(position: CLLocationCoordinate2D.init(latitude: 37.7906928118546, longitude: -122.405601739883), placeID: "ChIJAAAAAAAAAAARknLi-eNpMH8", color: .black, saved: true))
        markers.append(makeMarker(position: CLLocationCoordinate2D.init(latitude: 37.7887342497061, longitude: -122.407184243202), placeID: "ChIJAAAAAAAAAAARdxDXMalu6mY", color: .black, saved: true))
        
        makeShowListView()
        makeInformationView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Location initial function
     
     - Attention: test
     - Bug: test
     - Date: date
     - Experiment: test
     - Important: test
     - Invariant: test
     - Note: test
     - Precondition: test
     - Postcondition: test
     - Remark: test
     - Requires: test
     - Since: @0.0.1
     - Version: 1.0
     - Warning: test
     
     */
    func locationInit() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 100
        locationManager.startUpdatingLocation()
        
        placesClient = GMSPlacesClient.shared()
    }
    
    
    /**
     Google Map initial function
     
     - Requires:
     Google API Key
     
     - SeeAlso:
     AppDelegate file
     */
    func mapInit() {
        // if user current location can not get, it will be set default position
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
    }
    
    /**
     Information View, if user tapped a place, the view will be shown the place information
     
     - Note:
     Using Xib file for layout. See also: PlaceInformation.swift / xib
     
     */
    func makeInformationView() {
        placeInformationView = PlaceInformation(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        generalInformation = placeInformationView!
        
        guard let generalInformation = generalInformation else {
            print("nil error")
            return
        }
        
        // Set tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(detailView(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(tappedImage(_:)))
        tapImageGesture.delegate = self as? UIGestureRecognizerDelegate
        self.placeInformationView?.addGestureRecognizer(tapGesture)
        self.placeInformationView?.distanceIcon.addGestureRecognizer(tapImageGesture)
        self.view.addSubview(generalInformation)
        
        // Set constrains in manually
        generalInformation.translatesAutoresizingMaskIntoConstraints = false
        generalInformation.heightAnchor.constraint(equalToConstant: 100).isActive = true
        generalInformation.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        generalInformation.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.generalInfoBottomConstraints.append(generalInformation.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100))
        self.generalInfoBottomConstraints.append(generalInformation.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))
        
        // Set default
        self.generalInfoBottomConstraints[0].isActive = true
    }
    
    func makeShowListView() {
        showListView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        showListView.sectionHeaderHeight = 44
        showListView.rowHeight = 100
        
        showListView.delegate = self
        showListView.dataSource = self
        
        showListView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        self.view.addSubview(showListView)
        
        // Set constrains
        showListView.translatesAutoresizingMaskIntoConstraints = false
        showListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        showListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        showListView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        
        self.showListViewHeightConstraints.append(showListView.heightAnchor.constraint(equalToConstant: 44))
        self.showListViewHeightConstraints.append(showListView.heightAnchor.constraint(equalToConstant: (self.view.bounds.height / 1.3)))
        self.showListViewHeightConstraints[0].isActive = true
    }
    
    func detailView(_ sender: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //set placeID
        vc.placeID = (self.placeInformationView?.gerGooglePlaceID())!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tappedImage(_ sender: UITapGestureRecognizer) {
        print("image tapped")
        //print(self.placeInformationView?.saved)
        makeAlert()
    }
    
    /**
     Information View hide animation
     
     */
    func animateHideView() {
        self.generalInfoBottomConstraints[1].isActive = false
        self.generalInfoBottomConstraints[0].isActive = true
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    /**
     Information View show animation
     
     */
    func animateShowView() {
        self.generalInfoBottomConstraints[0].isActive = false
        self.generalInfoBottomConstraints[1].isActive = true
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func tapToggleAction(_ sender: UITapGestureRecognizer) {
        if flag {
            self.showListViewHeightConstraints[1].isActive = false
            self.showListViewHeightConstraints[0].isActive = true
            showLists.text = "Show Lists"
            flag = false
        } else {
            self.showListViewHeightConstraints[0].isActive = false
            self.showListViewHeightConstraints[1].isActive = true
            showLists.text = "Close"
            flag = true
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func makeAlert() {
        let alert = UIAlertController(title:"Save to Folder", message: "Select a folder to save your spot", preferredStyle: UIAlertControllerStyle.alert)
        
        let action1 = UIAlertAction(title: "Beaches", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション１をタップした時の処理")
        })
        
        let action2 = UIAlertAction(title: "Cafes", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("アクション２をタップした時の処理")
        })
        
        //The last one creates another dialog
        
        let action3 = UIAlertAction(title: "Create Folder", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
            let alert = UIAlertController(title: "Create Folder", message: "Type Folder Name", preferredStyle: .alert)
            
            // Submit button
            let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
                // Get 1st TextField's text
                let textField = alert.textFields![0]
                print(textField.text!)
            })
            
            // Cancel button
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            
            // Add 1 textField and customize it
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                textField.placeholder = "Type something here"
                textField.clearButtonMode = .whileEditing
            }
            
            // Add action buttons and present the Alert
            alert.addAction(submitAction)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        })
        
        
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルをタップした時の処理")
        })
        
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        headerView.backgroundColor = UIColor.white
        
        showLists = UILabel()
        showLists.text = "Show Lists"
        showLists.textAlignment = .center
        showLists.sizeToFit()
        showLists.center = headerView.center
        showLists.textColor = UIColor.black
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToggleAction(_:))))
        headerView.addSubview(showLists)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        placesClient.lookUpPlaceID(markers[indexPath.row].snippet!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                //print("No place details for \(placeID)")
                return
            }
            
            cell.placeName.text = place.name
            cell.placeAddress.text = place.formattedAddress
            cell.placeRating.text = String(place.rating)
            
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell tapped: \(indexPath.row)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //set placeID
        vc.placeID = (self.markers[indexPath.row].snippet)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        //print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
