//
//  NetworkManager.swift
//  Cars
//
//  Created by Suhas on 9/26/17.
//  Copyright © 2017 Suhas. All rights reserved.
//

import Foundation
import Alamofire


/* Class dedicated to the Network layer */

enum ServiceType: URLConvertible{
    
    case serviceLoadCars //Add more calls later
    
    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    //TODO : ADD UR LCONSTANTS FILE
    var URLString : String{
        switch self{
        case .serviceLoadCars:
            return "http://www.codetalk.de/cars.json"
            //Add more when required
//        default://for future use - delete the default to suppress the warning
//            return "http://www.codetalk.de"
        }
    }
    var requestMethod : Alamofire.HTTPMethod{
        switch self{
        case .serviceLoadCars:
            return .get
            //Add more when required
//        default: //for future use - delete the default to suppress the warning
//            return .get
        }
    }
    var headers:[String : String]{
        switch self{
        case .serviceLoadCars:
            var values = ["Content-Type": "application/json"]
            values ["Accept-Encoding"] = "gzip"
            return values
        //Add more when required
//                default:
//            var values = ["Content-Type": "application/json"]
//            values ["Accept-Encoding"] = "gzip"
//            return values
        }
    }
}

class NetworkManger: NSObject {
    //not for v6 - need to handle differently for v6
    class func requestForType(serviceType : ServiceType, params:[String: Any]?, completionBlock :@escaping (_ response:Array<Any>?,_ error: NSError?) -> ()) {
        //TODO:CHECK FOR NETWORK CONNECTION USING REACHABILITY
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        Alamofire.request(serviceType.URLString, method: serviceType.requestMethod, parameters: params, encoding: URLEncoding.default, headers: serviceType.headers).responseJSON{ response in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(response)
                switch response.result{
                case .success(let value):
                    if value is NSNull{
                        // SERVER MESS - SENDING NOTHING INSIDE SUCCESS
                        completionBlock(["success"], nil)
                        return
                    }
                    let responseValue = value as? Array<Any>
                    completionBlock(responseValue!, nil)
                case .failure(let error):
                    if (response.response?.statusCode == 304){
                        completionBlock(Array<Any>(), nil)
                    }else{
                        print(Error.self)
                        completionBlock(nil, error as NSError)
                        if error.localizedDescription == "cancelled" {
                        } else {
                            DispatchQueue.main.async() {
                                //Show aleart to the user
                            }
                        }
                    }
                }
            }
        }
    }
}
