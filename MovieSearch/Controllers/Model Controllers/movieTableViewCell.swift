//
//  movieTableViewCell.swift
//  MovieSearch
//
//  Created by Brooke Kumpunen on 3/22/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//
//Okay, this file needs to have all my IBOutlets for the labels and the image. There isn't anything that needs to be "smart" about this cell, either, so we can just update the views and such right on here. First let's add the outlets.

import UIKit

class movieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
