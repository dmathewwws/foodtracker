//
//  LoginViewController.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class LoginViewController: UIViewController {

    @IBOutlet weak var logInUserNameTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    
    
    @IBAction func logInButton(sender: UIButton) {
        
        let userName = logInUserNameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let password = logInPasswordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        PFUser.logInWithUsernameInBackground(userName, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let navController = storyboard.instantiateViewControllerWithIdentifier("TableVIewNavigation")
//                self.navigationController!.pushViewController(tabBarViewController!, animated: true)
                self.showViewController(navController, sender: nil)
//                self.navigationController?.pushViewController(navController, animated: true)
//                self.navigationController?.showViewController(navController, sender: nil)
                
            } else {
                // The login failed. Check error to see why.
                print("FUCK U!")
            }
        }
    }
}
