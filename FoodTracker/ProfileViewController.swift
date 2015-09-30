//
//  ProfileViewController.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var option: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let currentUser = User.currentUser()
        
//        profilePhoto.image = currentUser?.profilePhoto
        userNameLabel.text = currentUser?.username
        option.text = currentUser?.option
        
        if let userPicture = currentUser?.profilePhoto {
            
            userPicture.getDataInBackgroundWithBlock { data, error in
                
                if let newData = data {
                    let image = UIImage(data: newData)
                    self.profilePhoto.image = image
                }
            }
            
        }
        
    }
}
