//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Brooke Kumpunen on 3/22/19.
//  Copyright © 2019 Rund LLC. All rights reserved.
//
//Alrighty, got my models working. Let's put it all into the views now and see if it's going to work.

import UIKit

class MovieListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        //Last thing. I'll need to be able to fetch movies and send them into the movies array below. I will call fetchMovies here.
        getMovies()
        
    }
    
    //MARK: - Methods
    func getMovies() {
        guard let searchTerm = movieSearchBar.text else {return}
        MovieController.shared.searchMovies(with: searchTerm) { (movie) in
            self.movies = movie
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Properties
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Methods
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // In order to complete this, I need to know the number of movies I have displayng. So I'll need a source of truth here.
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! movieTableViewCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//I do not need a segue, or the delete functions. However, when I finish the main functionality, I can try to come back on a different branch and see if I can add in another tableView with movie detail. dunno about delete, unless I made a category of favorite movies or something. Whoa.


//In order to use the searchBar fancy features, I'll need to make this the delegate for the searchbar class.
extension MovieListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MovieController.shared.searchMovies(with: searchText) { (movies) in
            self.movies = movies
        }
    }
}
