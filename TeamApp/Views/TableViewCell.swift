//
//  TableViewCell.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView! {
        didSet {
            pokemonImageView.contentMode = .scaleAspectFit
            pokemonImageView.clipsToBounds = true
            pokemonImageView.layer.cornerRadius = pokemonImageView.frame.height / 2
            pokemonImageView.backgroundColor = .white
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods

    func configur(pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        networkManager.fetch(dataType: Character.self, url: pokemon.url) { character in
            print("Character fetched:", character)
            self.networkManager.fetchImage(from: character.sprites.other.home.front_default) { data in
                print("Image data fetched:", data)
                self.pokemonImageView.image = UIImage(data: data)
            }
        }
      
    }
}
            

