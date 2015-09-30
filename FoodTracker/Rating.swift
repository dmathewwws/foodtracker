//
//  Rating.swift
//  FoodTracker
//
//  Created by Daniel Mathews on 2015-09-30.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation

import UIKit
import Parse
import Bolts

class Rating: PFObject, PFSubclassing {
    // MARK: Properties
    
    @NSManaged var user: User
    @NSManaged var rating: Int
    
    static func parseClassName() -> String {
        return "Rating"
    }

}