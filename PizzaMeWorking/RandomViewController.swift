//
//  RandomViewController.swift
//  PizzaMe
//
//  Created by Maxim Rose on 7/28/16.
//  Copyright © 2016 Matthew Porter. All rights reserved.
//

import UIKit
import MapKit

class RandomViewController: UIViewController {
    
    var mapItems: [MKMapItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in mapItems! {
            print(item.name!)
        }
    }
    
}
