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
    var pizzaItem: MKMapItem?
    @IBOutlet weak var pizzaMeButton: UIButton!
    @IBOutlet weak var callPizzaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPizzaButton.hidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
//        for item in mapItems! {
//            print(item.name!)
//        }
    }
    
    
    @IBAction func pizzaMeButtonPressed(sender: UIButton) {
        //placeholder actions until function is added
        randomPizza()
        pizzaMeButton.hidden = true
        callPizzaButton.hidden = false
        callPizzaButton.titleLabel?.text = pizzaItem!.name!
//        let alertController = UIAlertController(title: "Pizza Me!", message:
//            "Out of slices! Pay .99¢ for more?", preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.addAction(UIAlertAction(title: "Just kidding. Enjoy your pizza!", style: UIAlertActionStyle.Default,handler: nil))
//        
//        self.presentViewController(alertController, animated: true, completion: nil)

    }
    @IBAction func callPizzaButtonPressed(sender: UIButton) {
        print("pizza call made to \(pizzaItem!.phoneNumber!)")
        if let url = NSURL(string: "tel://\(pizzaItem!.phoneNumber!)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func randomPizza() -> MKMapItem{
        let randomIndex = Int(arc4random_uniform(UInt32(mapItems!.count)))
        print(mapItems![randomIndex])
        pizzaItem = mapItems![randomIndex]
        return mapItems![randomIndex]
    }
}
