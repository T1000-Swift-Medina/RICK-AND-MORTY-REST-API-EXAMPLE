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
    var id : Int
    var name : String
    var status : String
    var species : String
}
