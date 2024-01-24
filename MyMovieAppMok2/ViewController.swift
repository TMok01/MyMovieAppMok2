//
//  ViewController.swift
//  MyMovieAppMok2
//
//  Created by TYLER MOK on 1/22/24.
//

import UIKit

struct Rating: Codable {
    var Source: String
    var Value: String
}

struct Movie: Codable {
    var Actors: String
    var Country: String
    var Director: String
    var Metascore: String
    var Released: String
    var Ratings: [Rating]
}

struct MovieSearch: Codable {
   var Title: String
    var Year: String
    
}

struct SearchResult: Codable {
    var Search: [MovieSearch]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var searchBarOutlet: UITextField!
    
    
    var moovies : [MovieSearch] = []
    
    @IBOutlet weak var movieNameSearch: UITextField!
    
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        getMovie()
        // Do any additional setup after loading the view.
    }

    
    
  
    
    
    
    func getMovie() {
        let session = URLSession.shared
        
        let movieURL = URL(string: "http://www.omdbapi.com/?s=\(searchBarOutlet.text!)&apikey=f8847c8e")
        
        // creating data from the api call
        let dataTask = session.dataTask(with: movieURL!) { [self]
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error:\n\(error)")
            }
            else {
                if let d = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary {
                        print(jsonObj)
                        
                        //get Movie object with JSONDecoder
                        if let search = try? JSONDecoder().decode(SearchResult.self, from: d) {
                            moovies = search.Search
                            self.tableViewOutlet.reloadData()
                            for m in moovies {
                                print(m.Title)
                            }
                                
                            
                            print(search.Search[0].Title)
                        }
                                                
                        
                    
                        }
                    
                        }
                        else {
                            print("error decoding to movie object")
                        }
                        
                        }
                        
                    }
                dataTask.resume()
                }
                
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moovies.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(moovies[indexPath.row].Title)"
        return cell
    }
    
    
    
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        
        getMovie()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    
    
            }
      
    
    
    
    



