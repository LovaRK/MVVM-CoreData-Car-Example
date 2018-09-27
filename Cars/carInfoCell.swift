//
//  carInfoCell.swift
//  Cars
//
//  Created by Suhas on 9/26/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import UIKit
import AlamofireImage

protocol carInfoCellDelegate: class{
    func showOnMap(cell:carInfoCell)
}


class carInfoCell: UITableViewCell {
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var fuelTypeValue: UILabel!
    @IBOutlet weak var fuelLevelValue: UILabel!
    
    weak var carDelegate: carInfoCellDelegate?

    @IBAction func showOnMap(_ sender: Any) {
        carDelegate?.showOnMap(cell: self)
    }
    
    var item: CarInfoViewModel? {
        didSet {
            makeLabel?.text = item?.make
            nameLabel?.text = item?.name
            licensePlateLabel?.text = item?.licensePlate
            fuelTypeValue?.text = item?.fuelType
            fuelLevelValue?.text = item?.fuelLevel
            let imageUrl = NSURL(string: (item?.imageURL)!)
            if let url = imageUrl {
            carImageView.af_setImage(withURL: url as URL)
            }
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carImageView?.layer.cornerRadius = 50
        carImageView?.clipsToBounds = true
        carImageView?.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImageView?.image = nil
    }
}

