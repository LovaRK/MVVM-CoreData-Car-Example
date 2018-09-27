//
//  Car+CoreDataProperties.swift
//  Cars
//
//  Created by Suhas on 9/25/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var id: String?
    @NSManaged public var modelIdentifier: String?
    @NSManaged public var modelName: String?
    @NSManaged public var name: String?
    @NSManaged public var make: String?
    @NSManaged public var group: String?
    @NSManaged public var color: String?
    @NSManaged public var series: String?
    @NSManaged public var fuelType: String?
    @NSManaged public var fuelLevel: Double
    @NSManaged public var transmission: String?
    @NSManaged public var licensePlate: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var innerCleanliness: String?
    @NSManaged public var imageUrl: String?

    //    var imageURL: String {
//        get {
//            return "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(modelIdentifier ?? "mini")/\(color ?? "midnight_black")/2x/car.png"
//        }
//    }
    
    
    
    func parseWith(response:[String:Any]){
        //Assuming data is always present - TODO - check for nulL/nil response and handle it
        //TODO - create a file for constants.
        self.id = response["id"] as? String
        self.modelIdentifier = response["modelIdentifier"] as? String
        self.modelName = response["modelName"] as? String
        self.name = response["name"] as? String
        self.make = response["make"] as? String
        self.group = response["group"] as? String
        self.color = response["color"] as? String
        self.series = response["series"] as? String
        self.fuelType = response["fuelType"] as? String
        self.transmission = response["transmission"] as? String
        self.licensePlate = response["licensePlate"] as? String
        self.innerCleanliness = response["innerCleanliness"] as? String
        self.latitude = response["latitude"] as! Double
        self.longitude = response["longitude"] as! Double
        self.fuelLevel = response["fuelLevel"] as! Double
        self.imageUrl = response["carImageUrl"] as? String
    }

}
