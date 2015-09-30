//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Steve on 2015-09-26.
//  Copyright © 2015 Steve. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var meal:Meal? {
        didSet{
            if let meal = meal {
                nameLabel.text = meal.name
//                ratingControl.rating = meal.rating
                
                if let mealPhoto = meal.photo {
                    mealPhoto.getDataInBackgroundWithBlock { data, error in
                        if let newData = data {
                            let newImage = UIImage(data: newData)
                            self.photoImageView.image = newImage
                        }
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
