//
//  User.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts


class User: PFUser {
    
    @NSManaged var profilePhoto: PFFile?
    @NSManaged var option: String!
    
}