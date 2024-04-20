//
//  TableViewCell.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class PokemonViewCell: UITableViewCell {
    
    var pokemon: Pokemon!
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var pokemonImageView: UIImageView!
    func didSet() {
            pokemonImageView.contentMode = .scaleAspectFit
            pokemonImageView.clipsToBounds = true
            pokemonImageView.layer.cornerRadius = pokemonImageView.frame.height / 2
            pokemonImageView.backgroundColor = .white
        }
        
        
        
        // MARK: - Public methods
        
        func configure(pokemon: Pokemon) {
            nameLabel.text = pokemon.name
            NetworkManager.shared.fetch(dataType: Character.self, url: pokemon.url) { character in
                NetworkManager.shared.fetchImage(from: character.sprites.other.home.front_default) { [weak self] data in
                    switch data {
                    case .success(let imageData):
                        self?.pokemonImageView.image = UIImage(data: imageData)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        }
    }

