//
//  CharacterDetailsViewController.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    
    // MARK: - Public properties
    var pokemon: Pokemon!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // title = name.fillName
    }
   
    
}
