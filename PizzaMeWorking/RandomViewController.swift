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
    var pizzaButtons:[UIImage] = []
    var idx: Int = 0
    @IBOutlet weak var pizzaMeButton: UIButton!
    @IBOutlet weak var callPizzaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPizzaButton.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
        
        for i in 1 ..< 10 {
            let image = UIImage(named: "pizzaButton\(i).png") as UIImage?
            pizzaButtons.append(image!)
        }
        callPizzaButton.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    
    @IBAction func pizzaMeButtonPressed(_ sender: UIButton) {
//        callPizzaButton.hidden = true
        idx += 1
        if idx >= pizzaButtons.count {
            let alertController = UIAlertController(title: "Pizza Me!", message:
                "Out of slices! Pay .99¢ for more?", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Just kidding. Enjoy your pizza!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)

            idx = 0
        }
        pizzaMeButton.setImage(pizzaButtons[idx], for: UIControlState())
        //placeholder actions until function is added
        randomPizza()
        
// button state can be differen and need to set text with setTitle
        callPizzaButton.setTitle(pizzaItem!.name!, for: UIControlState())
        callPizzaButton.isHidden = false

    }
    @IBAction func callPizzaButtonPressed(_ sender: UIButton) {
        let formatedNumber = pizzaItem!.phoneNumber!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
//        if let phoneCallURL:NSURL = NSURL(string: "tel://\(formatedNumber)") {
//            let application:UIApplication = UIApplication.sharedApplication()
//            if (application.canOpenURL(phoneCallURL)) {
//                print("pizza call made to \(pizzaItem!.phoneNumber!)")
//                application.openURL(phoneCallURL);
//            }
//        }
        if let url = URL(string: "tel://\(formatedNumber)") {
            print("pizza call made to \(pizzaItem!.phoneNumber!)")
            UIApplication.shared.openURL(url)
        }
    }
    
    func randomPizza() -> MKMapItem{
        let randomIndex = Int(arc4random_uniform(UInt32(mapItems!.count-1)))
//        print(mapItems![randomIndex])
        pizzaItem = mapItems![randomIndex]
        return mapItems![randomIndex]
    }
}
