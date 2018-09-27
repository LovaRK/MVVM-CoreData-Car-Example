//
//  ViewControllerViewModel.swift
//  Cars
//
//  Created by Suhas on 9/25/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import Foundation
import UIKit


/*ViewController view model*/
class ViewControllerViewModel: NSObject {
    var items = [Any]()
    weak var carDelegate: carInfoCellDelegate?
    
    func refreshWith(data: Array<Any>, _ completionBlock : @escaping ()->()) {
        self.items = data
        completionBlock()
    }
}

extension ViewControllerViewModel: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: carInfoCell.identifier, for: indexPath) as? carInfoCell {
                cell.item = item as? CarInfoViewModel
                cell.carDelegate = self
                return cell
            }
        return UITableViewCell()
    }
}

extension ViewControllerViewModel : carInfoCellDelegate{
    func showOnMap(cell:carInfoCell){
        self.carDelegate?.showOnMap(cell: cell)
    }
}


/* Cell view model */
class CarInfoViewModel: NSObject {
    var modelName: String?
    var name: String?
    var make: String?
    var fuelType: String?
    var fuelLevel: String?
    var licensePlate: String?
    var latitude: Double
    var longitude: Double
    var imageURL: String?

    init?(data: Car) { //Can add any thing extra which is needed for UI population like - section titles etc.
        self.make = data.make
        self.modelName = data.modelName
        self.name = data.name
        self.fuelType = data.fuelType
        self.licensePlate = data.licensePlate
        self.fuelLevel = String(format:"%f", data.fuelLevel)
        self.imageURL = data.imageUrl
        self.latitude = data.latitude
        self.longitude = data.longitude
    }
}
