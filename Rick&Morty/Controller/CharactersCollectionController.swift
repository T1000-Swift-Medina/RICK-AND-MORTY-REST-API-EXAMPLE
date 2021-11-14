//
//  CharactersCollectionViewController.swift
//  Rick&Morty
//
//  Created by Abdulaziz Alfayaa on 14/11/2021.
//

import UIKit

class CharactersCollectionController: UICollectionViewController {
    var rickAndMortyCharacters : RickAndMortyResponse!
    var selectedCharacterIndex : Int!
    var charactersImages = [Data]()
    
    private let apiSession = URLSession.shared
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        if (!charactersImages[indexPath.row].isEmpty) {
        characterCell.characterImageView.image = UIImage(data: charactersImages[indexPath.row])
            characterCell.characterNameLabel.text = rickAndMortyCharacters.results[indexPath.row].characterName
        } else {
            characterCell.characterImageView.image = UIImage(named: "rick-morty-rick")

        }

        return characterCell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacterIndex = indexPath.row
        performSegue(withIdentifier: "characterDetailsCollectionSegue", sender: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "characterCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        getCharacters()

        // Do any additional setup after loading the view.
    }
    
    func getCharacters(){
        var apiURLComponents = URLComponents()
        apiURLComponents.scheme = "https"
        apiURLComponents.host = "rickandmortyapi.com"
        apiURLComponents.path = "/api/character"
        
        let apiRequest = URLRequest(url: apiURLComponents.url!)
        
        
        apiSession.dataTask(with: apiRequest) { (data : Data?, response : URLResponse?, error : Error?) in
            do {
                if (error == nil) {
                    let jsonDecoder = JSONDecoder()
                    let charactersResponse = try jsonDecoder.decode(RickAndMortyResponse.self, from: data!)
                    
                    self.rickAndMortyCharacters = charactersResponse
                    self.rickAndMortyCharacters.results.map { character in
                        self.fetchCharactersImages(character: character)
                        print("Loading Character Image: \(character.characterName)")
                    }

                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }.resume()

    }
    func fetchCharactersImages(character: Character) {
        apiSession.dataTask(with: character.characterImageURL!) { (data: Data?, response: URLResponse?, error: Error?) in
            if (error == nil){
                self.charactersImages.append(data!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.resume()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "characterDetailsCollectionSegue") {
            let characterDetailsVC = segue.destination as! CharacterDetailsViewController
            
            characterDetailsVC.character = rickAndMortyCharacters?.results[selectedCharacterIndex]
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
