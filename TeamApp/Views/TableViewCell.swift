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
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
           
    }
        
}
    
