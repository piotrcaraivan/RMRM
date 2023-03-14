//
//  Character.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 11.03.2023.
//

import Foundation

struct RMCharacter: Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Place
    let location: Place
    let image: String
    let episode: [String]
    let url: String
    private var _isFavorite: Bool?
    
    var isFavorite: Bool {
        get {
            _isFavorite ?? false
        }
        set {
            _isFavorite = newValue
        }
    }
}

struct Place: Decodable {
    let name: String
    let url: String
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}

enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown
}
