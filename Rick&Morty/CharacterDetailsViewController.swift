//
//  CharacterDetailsViewController.swift
//  Rick&Morty
//
//  Created by Abdulaziz Alfayaa on 14/11/2021.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    var character : Character!
    
    @IBOutlet var characterStatusLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var characterSpeciesLabel: UILabel!
    @IBOutlet var characterEpisodeCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        characterStatusLabel.text = character.characterStatus
        characterNameLabel.text = character.characterName
        characterSpeciesLabel.text = character.characterStatus
        characterEpisodeCountLabel.text = String(character.characterEpisodes.count)
    }
    
    @IBAction func backToCharactersButtonPressed(_ sender: Any) {
    }

}
