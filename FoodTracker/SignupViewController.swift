//
//  SignupViewController.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-28.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var signUpUsernameTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let picker = UIImagePickerController()
    var pickerDataSource:[String] = ["Food Critic", "Casual Foodie"]
    var selectedPicker: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        selectedPicker = pickerDataSource[0]
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureImage.contentMode = .ScaleAspectFit
            profilePictureImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Pickerview datasource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    // MARK: Pickerview delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDataSource[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            selectedPicker = pickerDataSource[0]
            print("\(selectedPicker)")
        }else {
            selectedPicker = pickerDataSource[1]
            print("\(selectedPicker)")
            
        }
    }
    
    // MARK: Actions
    
    @IBAction func tapRecgonizer(sender: UITapGestureRecognizer) {
        
        picker.allowsEditing = false
        
        let alertController = UIAlertController(title: "Choose a place to select an image", message: "From library or take a photo now!", preferredStyle:  UIAlertControllerStyle.ActionSheet)
        
        let photoLib = UIAlertAction(title: "Photo Library", style: .Default) { (action) -> Void in
//            action.title = ""
            self.picker.sourceType = .PhotoLibrary
            self.presentViewController(self.picker, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .Default) { (UIAlertAction) -> Void in
            self.picker.sourceType = .Camera
//            presentViewController(picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (UIAlertAction) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
        alertController.addAction(photoLib)
        alertController.addAction(cancel)
        
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            alertController.addAction(camera)
        }
        
//        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        
        
        let newUserName = signUpUsernameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let newPassword = signUpPasswordTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        let newUser = User()
        newUser.username = newUserName
        newUser.password = newPassword
        
        
//        let profileImage = self.profilePictureImage.image
        
        
        
        /*
        
        if (self.profileImage.image != nil) {
            NSData *data = UIImageJPEGReprpesentation(self.profileImage.image, 0.95);
            if (data != nil) {
                newUser.profilePhoto = [PFFile alloc] initWithData:data];
            }
        }
        
        
        */
        
        
        
        if let img = self.profilePictureImage.image,
            let imageData = UIImageJPEGRepresentation(img, 0.95) {
                
                let imageFile = PFFile(name: "profile_picture.jpg", data: imageData)
                
                newUser.profilePhoto = imageFile
                
        }  else {
            
            print("whoops!")
        }
        
        newUser.option = self.selectedPicker
        
        newUser.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let _ = error.userInfo["error"] as? NSString
                print("UHHHHH!!!!!")
            } else {
                    // Hooray! Let them use the app now.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let navController = storyboard.instantiateViewControllerWithIdentifier("TableVIewNavigation")
                //                self.navigationController!.pushViewController(tabBarViewController!, animated: true)
                self.showViewController(navController, sender: nil)
//                self.navigationController?.showViewController(navController, sender: nil)
                
                
            }
        }
    }
}
