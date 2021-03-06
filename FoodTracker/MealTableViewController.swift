//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-26.
//  Copyright © 2015 Steve. All rights reserved.
//

import UIKit
import Parse
import Bolts

protocol MealTableViewControllerDelegate {
    func didAddNewMealItem()
}

class MealTableViewController: UITableViewController, MealTableViewControllerDelegate {
    // MARK: Properties
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()

        loadMeals()
    
    }
    
    func didAddNewMealItem() {
        loadMeals()
    }
    
    func loadSampleMeals() {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.meal = meal
    
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new meal.")
            let navVC = segue.destinationViewController as! UINavigationController
            let mealVC = navVC.topViewController as! MealViewController
            mealVC.delegate = self
        }
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            //saveMeals()
        }
    }
    
    // MARK: NSCoding
    
    func saveMeals() {
        
        
        
    }
    
    func loadMeals() {//-> [Meal]? {
        let query = Meal.query()
        query?.findObjectsInBackgroundWithBlock {
            (objects:[PFObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [Meal]{
                    //print("objects is \(objects)")
                    
                    self.meals = objects
                    
                    for meal in self.meals {
                        let ratingsRelation = meal.relationForKey("ratings")
                        let query = ratingsRelation.query()
                        query?.cachePolicy = .NetworkOnly
                        query?.findObjectsInBackgroundWithBlock({ (objects, ErrorType) -> Void in
                            //
                            //print("meal ratings is \(objects)")
                            //print("self.meals is \(self.meals)")

                        })
                    }
                    

                    self.tableView!.reloadData()
                }
            }
        }
    }
    
        @IBAction func logOutButton(sender: UIBarButtonItem) {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            let navController = storyboard.instantiateViewControllerWithIdentifier("LogInViewController")
            presentViewController(navController, animated: true, completion: nil)
            User.logOut()
            
        }
    
}