//
//  CharactersTableViewController.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
    
    //MARK: Private properties
    var pokemonsAll: [Pokemon] = []
    
    private let networkManager = NetworkManager.shared

    private var filteredPokemon = [Pokemon]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
   
    

    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellUI")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        fetchPokemons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Navigation
    // Здесь будем подготавливать данные для передачи на экран с детальной инфой
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let pokemon: Pokemon
                
                if isFiltering {
                    pokemon = filteredPokemon[indexPath.row]
                } else {
                    pokemon = pokemonsAll[indexPath.row]
                }
                
                let detailVC = segue.destination as! CharacterDetailsViewController
                detailVC.pokemon = pokemon
            }
        }
    }
    

    
    private func fetchPokemons() {
        networkManager.fetch(dataType: PokemonApp.self, url: PokemonAPI.url.rawValue) { pokemonApp in
            self.pokemonsAll = pokemonApp.results
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension CharactersTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsAll.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUI", for: indexPath)
        
        let pokemon = pokemonsAll[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = pokemon.name ?? "pik"
        print(pokemon.url ?? "pik")
        cell.contentConfiguration = config
        
        return cell
    }
}




// MARK: - UISearchResultsUpdating
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPokemon = searchText.isEmpty ? pokemonsAll :
            pokemonsAll.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}


        
        
        
        
        
        
        /*
         Работающий код
         
         
         
         
         //        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
         let pokemon = (isFiltering
         ? filteredPokemon[indexPath.row]
         : myPokemon?.results[indexPath.row])
         config.text = pokemon?.name ?? "pikachu"
         print(pokemon?.url ?? "pikachu")
         
         cell.contentConfiguration = config
         //        cell.configure(with: pokemon)
         
         return cell
         
         
         
         //        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUI", for: indexPath)
         //        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
         //        let pokemon = (isFiltering
         //                       ? filteredPokemon[indexPath.row]
         //                       : myPokemon?.results[indexPath.row])!
         //        cell.configure(with: pokemon)
         //        return cell
         
         
         
         
         
         
         }
         
         
         
         
         */
