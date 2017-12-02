//
//  Meal.swift
//  FoodTracker.VA
//
//  Created by Apple on 11/22/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    //MARK: Types
    struct Propertykey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Propertykey.name)
        aCoder.encode(photo, forKey: Propertykey.photo)
        aCoder.encode(rating, forKey: Propertykey.rating)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is repuired. If we connot decode a name string, the inittializer should fail.
        guard let name = aDecoder.decodeObject(forKey: Propertykey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use condittional cast.
        let photo = aDecoder.decodeObject(forKey: Propertykey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: Propertykey.rating)
        //Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
}

