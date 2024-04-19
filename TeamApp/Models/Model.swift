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

struct MockDataPokemon {
    var pokemonName: String
    var pokemonImage: String
    
    static func makeRandomList() -> [MockDataPokemon] {
        let dataStore = DataStore()
        var pokemons: [MockDataPokemon] = []
        
        let pokemonNames = dataStore.pokemonNames.shuffled()
        let pokemonImages = dataStore.pokemonImages.shuffled()

        
        for index in 0..<pokemonNames.count {
            let pokemon = MockDataPokemon(
                pokemonName: pokemonNames[index],
                pokemonImage: pokemonImages[index]
            )
            
            pokemons.append(pokemon)
        }
        
        return pokemons
    }
}

class DataStore {
    let pokemonNames = [
        "pikachu",
        "charmander"
    ]
    
    let pokemonImages = [
        "person.fill",
        "gear"
    ]
}


