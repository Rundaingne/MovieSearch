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
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    //MARK: - Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    func updateViews() {
        guard let movie = movie else {return}
        movieTitleLabel.text = movie.movieName
        movieRatingLabel.text = "\(movie.rating)"
        movieOverviewLabel.text = movie.overview
        //I will need to update the image view here as well.
        fetchAndSetImageView()
    }
    
    func fetchImage(movieImagePath: String, completion: @escaping (UIImage?) -> Void) {
        //Create the url of the image. Not too difficult.
        ////Display the poster of each movie on your custom cell (Hint, the URL for fetching a movies image is: http://image.tmdb.org/t/p/w500/(imageEndpoint)
        let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
        //Alright, got the baseURL. Now attach the dang pathComponent to it.
        guard let image = movie?.movieImagePath else {completion(nil); return}
        guard let imagePath = baseImageURL?.appendingPathComponent(image) else {completion(nil); return}
        //Call the data task.
        let dataTask = URLSession.shared.dataTask(with: imagePath) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
    
    func fetchAndSetImageView() {
        guard let imagePath = movie?.movieImagePath else {return}
        fetchImage(movieImagePath: imagePath) { (image) in
            DispatchQueue.main.async {
                self.moviePosterImageView.image = image
            }
        }
    }
}

//Aaaand, that is it for the cell. Cool beans B)
