//
//  CharacterCellViewModel.swift
//  Rick&Morty
//
//  Created by Петр Караиван on 11.03.2023.
//

import Foundation

struct CharacterCellViewModel: Hashable {
    let id: Int
    let name: String
    let image: String
    
    init(_ character: RMCharacter) {
        id = character.id
        name = character.name
        image = character.image
    }
}
