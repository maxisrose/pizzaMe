//
//  ListTableViewController.swift
//  PizzaMe
//
//  Created by Maxim Rose on 7/28/16.
//  Copyright © 2016 Matthew Porter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ListTableViewController: UITableViewController, MKMapViewDelegate , CLLocationManagerDelegate {
    
    var itemsArray: [MKMapItem] = []
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
        searchForPizza()
        myMapView.isHidden = true
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Make rows")
        print(itemsArray.count)
        return itemsArray.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pizzaCell")!
        cell.textLabel?.text = itemsArray[indexPath.row].name!
        cell.detailTextLabel?.text = itemsArray[indexPath.row].phoneNumber!
        print("making a cell!")
        return cell
    }
    
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("pizzaCell")!
    //        cell.textLabel?.text = itemsArray[indexPath.row].name!
    //        cell.detailTextLabel?.text = itemsArray[indexPath.row].phoneNumber!
    //        print(itemsArray)
    //        print(itemsArray[indexPath.row].name)
    //        print("Making a cell")
    //        return cell
    //    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let formatedNumber = itemsArray[indexPath.row].phoneNumber!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let url = URL(string: "tel://\(formatedNumber)") {
            print("pizza call made to \(itemsArray[indexPath.row].phoneNumber!)")
            UIApplication.shared.openURL(url)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RandomViewController
        destination.mapItems = self.itemsArray
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Init the zoom level
        let coordinate: CLLocationCoordinate2D = (locationManager.location?.coordinate)!
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.myMapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        //        tabBarController?.childViewControllers[1]
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchForPizza()
        print("region did change")
        tableView.reloadData()
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
    
    func searchForPizza() {
        itemsArray = []
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pizza"
        request.region = myMapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {
            response, error in
            if error != nil {
                print(error)
            } else if let mapItems = response?.mapItems {
                for item in mapItems {
                    self.itemsArray.append(item)
                    //                    print(item.name)
                }
                print("search has \(self.itemsArray.count)")
                self.tableView.reloadData()
            }
            
        })//close search
    }//close search for pizza
    
    
}
