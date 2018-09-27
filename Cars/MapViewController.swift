//
//  MapViewController.swift
//  Cars
//
//  Created by Suhas on 9/26/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var lattitude : Double?
    var longitude : Double?
   
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let span : MKCoordinateSpan = MKCoordinateSpanMake(0.1,0.1)
        //TODO - if let check for lat long - error handling
        let location : CLLocationCoordinate2D =  CLLocationCoordinate2DMake(self.lattitude!, self.longitude!)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "You Are Here"
        annotation.subtitle = "congratulations"
        self.map.addAnnotation(annotation)
    }
}
