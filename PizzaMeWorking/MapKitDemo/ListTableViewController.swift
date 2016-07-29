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

class ListTableViewController: UITableViewController {
    
    var itemsArray: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pizzaCell")!
        cell.textLabel?.text = "Pizza Butt"
        cell.detailTextLabel?.text = "1-(800)-CALLPIZZABUTT"
        return cell
    }
}
