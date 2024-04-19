//
//  Model.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import Foundation

struct PokemonApp: Decodable {
    let next: URL?
    let previous: URL?
    let results: [Pokemon]
}


struct Pokemon: Decodable {
    let name: String
    let url: String
    
    var description: String {
        """
Name: \(name)
"""
    }
}


struct Character: Decodable {
    let sprites: Sprites
}


struct Sprites: Decodable {
    let other: Home
}


struct Home: Decodable {
    let home: Front
}

struct Front: Decodable {
    let front_default: String
}

enum PokemonAPI {
    case baseURL
    
    var url: URL {
        switch self {
        case .baseURL:
            return URL(string: "https://pokeapi.co/api/v2/pokemon")!
        }
    }
    
}


