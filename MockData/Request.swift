//
//  Request.swift
//  MockData
//
//  Created by Cesar Gonzalez on 4/3/17.
//  Copyright © 2017 Cesar Gonzalez. All rights reserved.
//

import UIKit
import Parse

class Request: NSObject {
    
    class func postRequest(withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let request = PFObject(className: "Request")
        
        // Add relevant fields to the object
        request["rider"] = PFUser.current() // Pointer column type that points to PFUser
        request["locationLongitude"] = Double(30.2889)
        request["locationLatitude"] = Double(97.7364)
        request["destinationLongitude"] = Double(30.2827)
        request["destinationLatitude"] = Double(97.7382)
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = timeFormatter.string(from: date)
        request["time"] = timeString
        
        request["driver1"] = NSNull()
        request["driver2"] = NSNull()
        
        
        // Save object (following function will save the object in Parse asynchronously)
        request.saveInBackground(block: completion)
    }

}
