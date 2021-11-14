//
//  CharactersViewController.swift
//  Rick&Morty
//
//  Created by Abdulaziz Alfayaa on 14/11/2021.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCharacterIndex : Int!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rickAndMortyCharacters?.results.count ?? 0
    }
    
    var rickAndMortyCharacters : RickAndMortyResponse?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = rickAndMortyCharacters?.results[indexPath.row].characterName
        cell.detailTextLabel?.text = rickAndMortyCharacters?.results[indexPath.row].characterStatus
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacterIndex = indexPath.row
        performSegue(withIdentifier: "characterDetailsSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBOutlet var charactersTableView: UITableView!
    override func viewDidLoad() {
        fetchRickAndMortyCharacters()
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.backgroundColor = UIColor.clear
    }
    func fetchRickAndMortyCharacters(){
        var apiURL = URLComponents()
        apiURL.scheme = "https"
        apiURL.host = "rickandmortyapi.com"
        apiURL.path = "/api/character"
        
        let apiRequest = URLRequest(url: apiURL.url!)
        
        let apiSessionConfig = URLSessionConfiguration.default
        
        apiSessionConfig.allowsCellularAccess = false
        
        let apiSession = URLSession(configuration: apiSessionConfig)
        
        apiSession.dataTask(with: apiRequest) { (data : Data?, response : URLResponse?, error : Error?) in
            do {
                let jsonDecoder = JSONDecoder()
                let characters = try jsonDecoder.decode(RickAndMortyResponse.self, from: data!)
                self.rickAndMortyCharacters = characters

                print("Data Loaded")
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                }
            } catch {
                print("Error fetching data from API: \(error)")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "characterDetailsSegue") {
            
            let characterDetailsVC = segue.destination as! CharacterDetailsViewController
            
            characterDetailsVC.character = rickAndMortyCharacters?.results[selectedCharacterIndex]
        }
    }
}
