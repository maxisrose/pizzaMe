//
//  pickerViewController.swift
//  PizzaMe
//
//  Created by matthew porter on 7/25/16.
//  Copyright © 2016 Matthew Porter. All rights reserved.
//

import UIKit
import MapKit

protocol pickerViewControllerDelegate {
    func saveData(_ anonArray: [MKPointAnnotation])
}

class pickerViewController: UITableViewController, MKMapViewDelegate {
    var delegate: pickerViewControllerDelegate?
    var anonArray: [MKPointAnnotation] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anonArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        cell.textLabel?.text = anonArray[indexPath.row].title
        cell.detailTextLabel?.text = anonArray[indexPath.row].subtitle
        print("we made a cell")
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(anonArray)
        
    }
    //    func importData() {
    //        print("save")
    //        delegate?.saveData(anonArray)
    //    }
}
