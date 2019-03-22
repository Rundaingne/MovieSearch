//
//  MovieController.swift
//  MovieSearch
//
//  Created by Brooke Kumpunen on 3/22/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//
//Here I need to create my baseURL, do my queryItems, create a URL request, and pull the data down from the API. Since I am doing codable, I will make my completions contain my source of truth.

import Foundation

class MovieController {
    
    //Shared instance
    static let shared = MovieController()
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    //MARK: - Methods
    //I need to get(fetch) the movies.
    func searchMovies(with searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        //First things first. Build my URL. Make sure to use query items.
        guard let url = baseURL else {completion([]); return}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "1dbae9c4649709053b9777d147a48d9f")
        let querySearchItem = URLQueryItem(name: "&query", value: searchTerm)
        urlComponents?.queryItems = [apiKeyQueryItem, querySearchItem]
        //Jimminy that was hard to decipher. Okay, got my query items and my full url is below.
        guard let requestURL = urlComponents?.url else {completion([]); return}
        //Now, let's make the request.
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        //I am not sending any data, so I do not need to do the body.
        //Call the data task to actually get our data using the request.
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion([])
                return
            }
            //I have handled the error. Now let's check to see if we've got data.
            guard let data = data else {completion([]); return}
            do {
                let topLevelDictionary = try JSONDecoder().decode(MovieTopLevelDictionary.self, from: data)
                completion(topLevelDictionary.results)
                //BOOM. This will decode the whole json, and then return just the results array, which is where my movie data is stored. Now I have access to my movie struct's properties.
            } catch {
                print("There was an error in \(#function): \(error) \(error.localizedDescription)")
            }
        } //Don't forget to resume the data task.
        dataTask.resume()
    }
    
    //I will need to create a function to getImages here. But I will do that in a bit, after the I know the rest of the app is working.
}
