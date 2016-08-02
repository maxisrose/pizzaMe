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
        callPizzaButton.hidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
        
        for i in 1 ..< 10 {
            let image = UIImage(named: "pizzaButton\(i).png") as UIImage?
            pizzaButtons.append(image!)
        }
        callPizzaButton.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    
    
    @IBAction func pizzaMeButtonPressed(sender: UIButton) {
//        callPizzaButton.hidden = true
        idx += 1
        if idx >= pizzaButtons.count {
            let alertController = UIAlertController(title: "Pizza Me!", message:
                "Out of slices! Pay .99¢ for more?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Just kidding. Enjoy your pizza!", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

            idx = 0
        }
        pizzaMeButton.setImage(pizzaButtons[idx], forState: UIControlState.Normal)
        //placeholder actions until function is added
        randomPizza()
        
// button state can be differen and need to set text with setTitle
        callPizzaButton.setTitle(pizzaItem!.name!, forState: UIControlState.Normal)
        callPizzaButton.hidden = false

    }
    @IBAction func callPizzaButtonPressed(sender: UIButton) {
        let formatedNumber = pizzaItem!.phoneNumber!.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
//        if let phoneCallURL:NSURL = NSURL(string: "tel://\(formatedNumber)") {
//            let application:UIApplication = UIApplication.sharedApplication()
//            if (application.canOpenURL(phoneCallURL)) {
//                print("pizza call made to \(pizzaItem!.phoneNumber!)")
//                application.openURL(phoneCallURL);
//            }
//        }
        if let url = NSURL(string: "tel://\(formatedNumber)") {
            print("pizza call made to \(pizzaItem!.phoneNumber!)")
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func randomPizza() -> MKMapItem{
        let randomIndex = Int(arc4random_uniform(UInt32(mapItems!.count-1)))
//        print(mapItems![randomIndex])
        pizzaItem = mapItems![randomIndex]
        return mapItems![randomIndex]
    }
}
