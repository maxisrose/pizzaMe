
//
//  ViewController.swift
//  MapKitDemo
//
//  Created by matthew porter on 7/19/16.
//  Copyright © 2016 Matthew Porter. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation
import CoreLocation


var player: AVAudioPlayer?

class ViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate, pickerViewControllerDelegate{
    
    var pizzaImage: UIImage?
    let locationManager = CLLocationManager()
    var anonArray: [MKPointAnnotation] = []
    func saveData(anonArray: [MKPointAnnotation]) {
        self.anonArray = anonArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hid search bar
        pizzaMeSearch.hidden = true
        myMapView.showsUserLocation = true
        myMapView.delegate = self
        let image = UIImage(named: "pizzaIcon1")?.CGImage
        pizzaImage = UIImage(CGImage: image!, scale: 17.0, orientation: UIImageOrientation(rawValue: 1)!)
        
//        intro song
//        playSound()
    
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Init the zoom level
        let coordinate: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        let span = MKCoordinateSpanMake(0.8, 0.8)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.myMapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        //        tabBarController?.childViewControllers[1]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! pickerViewController
        destination.anonArray = self.anonArray
        destination.delegate = self
        print("In main view controller\(anonArray)")
    }
    
    @IBAction func pizzaMeButtonPressed(sender: UIButton) {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
        searchForPizza()
    }
    
    @IBOutlet weak var pizzaMeSearch: UITextField!
    @IBOutlet weak var myMapView: MKMapView!
    
    func searchForPizza() {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pizza"
        request.region = myMapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler({
            response, error in
                if error != nil {
                    print(error)
                } else if let mapItems = response?.mapItems {
                    for item in mapItems {
                      self.placeItemOnTheMap(item)
                    }
                }
            })
    }
    
    func playSound() {
        let url = NSBundle.mainBundle().URLForResource("Thats-Amore", withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func placeItemOnTheMap(item: MKMapItem){
        let annotation = MKPointAnnotation()
        annotation.coordinate = item.placemark.coordinate
        annotation.title = item.name
        annotation.subtitle = item.phoneNumber
//        annotation.subtitle = item.placemark
        myMapView.addAnnotation(annotation)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.image = pizzaImage
        view.canShowCallout = true
        return view
    }
}