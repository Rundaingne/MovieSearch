//
//  Movie.swift
//  MovieSearch
//
//  Created by Brooke Kumpunen on 3/22/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//

//Your project must use Codable and follow these requirements:

//Allow a user to search for a movie by name
//Display search results either in a table view or collection view.
//The results should show the movie title, rating, and summary.
//Display the poster of each movie on your custom cell (Hint, the URL for fetching a movies image is: http://image.tmdb.org/t/p/w500/(imageEndpoint) (Links to an external site.)Links to an external site.)

//1dbae9c4649709053b9777d147a48d9f -- my api Key.

//my baseURL = "https://api.themoviedb.org/3/search/movie"

import Foundation

struct Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case movieName = "title"
        case rating = "vote_average"
        case movieImagePath = "poster_path"
        case overview = "overview"
        
    }
    
    let movieName: String
    let rating: Int
    let movieImagePath: String
    let overview: String
    
}

struct MovieTopLevelDictionary: Codable {
    let results: [Movie]
}
