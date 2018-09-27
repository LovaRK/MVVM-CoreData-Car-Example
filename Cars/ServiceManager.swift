//
//  ServiceManager.swift
//  Cars
//
//  Created by Suhas on 9/26/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import Foundation

/* Class dedicated to the service layer */
class ServiceManager: NSObject {
     class func loadCars (_ completionBlock : @escaping (_ responseArray:Array<Any>?, _ errorObj : NSError?)->()) {
        NetworkManger.requestForType(serviceType: ServiceType.serviceLoadCars, params: nil) { (response, error) in
            if let error = error {
                completionBlock(nil, error)
            }else if let response = response {
                completionBlock(response, nil)
            }
        }
    }
}
