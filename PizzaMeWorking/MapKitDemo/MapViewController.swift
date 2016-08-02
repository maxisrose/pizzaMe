
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

class MapViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate, pickerViewControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
        zoomToLocation()
        
        //hid search bar
        pizzaMeSearch.hidden = true
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
    
//-------------------------- outlets and actions and variables --------------------------//
    
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBOutlet weak var pizzaMeSearch: UISearchBar!
    
    var pizzaImage: UIImage?
    let locationManager = CLLocationManager()
    var anonArray: [MKPointAnnotation] = []
    var itemsArray: [MKMapItem] = []
    let pizzaBool = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
//-------------------------- map View functions --------------------------//
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchForPizza()
        print("region did change")
    }

    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.image = pizzaImage
        view.canShowCallout = true
        return view
    }
    

//-------------------------- location manager functions --------------------------//
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Init the zoom level
        let coordinate: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.myMapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        //        tabBarController?.childViewControllers[1]
    }
    
//-------------------------- segue functions --------------------------//

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! RandomViewController
        destination.mapItems = self.itemsArray
    }
    
//-------------------------- other functions --------------------------//
    
    func zoomToLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func saveData(anonArray: [MKPointAnnotation]) {
        self.anonArray = anonArray
    }
    
    func searchForPizza() {
        anonArray = []
        itemsArray = []
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
                        self.itemsArray.append(item)
                    }
                    print(self.itemsArray.count)
                }
                if self.pizzaBool.pizzaForce {
                    self.performSegueWithIdentifier("pizzaMeSegue", sender: nil)
                }
            })//close search
    }//close search for pizza
    
    func placeItemOnTheMap(item: MKMapItem){
        let annotation = MKPointAnnotation()
        annotation.coordinate = item.placemark.coordinate
        annotation.title = item.name
        annotation.subtitle = item.phoneNumber
        //        annotation.subtitle = item.placemark
        myMapView.addAnnotation(annotation)
    }
    
    func playSound() {
        let url = NSBundle.mainBundle().URLForResource("Thats-Amore", withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
            guard let player = player else { return }
            if player.playing{
                player.stop()
            }else{
                player.prepareToPlay()
                player.play()
            }
            
        } catch let error as NSError {
            print(error.description)
        }
    }
}