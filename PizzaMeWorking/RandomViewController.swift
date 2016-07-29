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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
//        for item in mapItems! {
//            print(item.name!)
//        }
    }
    
}
