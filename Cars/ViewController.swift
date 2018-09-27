//
//  ViewController.swift
//  Cars
//
//  Created by Suhas on 9/25/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var carsTableView: UITableView!
    fileprivate let viewModel = ViewControllerViewModel()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        viewModel.carDelegate = self
        self.title = "CARS"
        carsTableView?.dataSource = viewModel
        carsTableView?.estimatedRowHeight = 100
        carsTableView?.rowHeight = UITableViewAutomaticDimension
        carsTableView?.register(carInfoCell.nib, forCellReuseIdentifier: carInfoCell.identifier)
        DataBaseManger.saveCarsToDb {
            let cars = DataBaseManger.loadCarsFromDb()
            self.viewModel.refreshWith(data: cars, { 
                self.carsTableView.reloadData()
            })
        }
    }
}

extension ViewController : carInfoCellDelegate{
    func showOnMap(cell:carInfoCell){
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let controller : MapViewController? = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        controller?.longitude = cell.item?.longitude
        controller?.lattitude = cell.item?.latitude
        self.present(controller!, animated: true, completion: nil)
    }
}
