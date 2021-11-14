//
//  CharacterModel.swift
//  Rick&Morty
//
//  Created by Abdulaziz Alfayaa on 14/11/2021.
//

import Foundation

class RickAndMortyResponse : Codable {
    var results : [Character]
}

struct Character : Codable {
    var characterID : Int
    var characterName : String
    var characterStatus : String
    var characterSpecies : String
    var characterEpisodes : [String]
    var characterImageURL : URL?
    
    enum CodingKeys : String, CodingKey {
        case characterID = "id"
        case characterName = "name"
        case characterStatus = "status"
        case characterSpecies = "species"
        case characterEpisodes = "episode"
        case characterImageURL = "image"
    }
}
