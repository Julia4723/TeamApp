//
//  CharactersTableViewController.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
    
    //MARK: Private properties
    var pokemons: [Pokemon]!
    var pokemonsMock: [MockDataPokemon] = []
    
    private let networkManager = NetworkManager.shared
    private var myPokemon: PokemonApp?

    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredPokemon: [Pokemon] = []
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
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellUI")
        setupSearchController()
        fetchData(from: PokemonAPI.baseURL.url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Navigation
    // Здесь будем подготавливать данные для передачи на экран с детальной инфой
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let pokemon = isFiltering 
        ? filteredPokemon[indexPath.row]
        : myPokemon?.results[indexPath.row]
        guard let characterDetailsVC = segue.destination as? CharacterDetailsViewController else { return}
        characterDetailsVC.pokemon = pokemon
       // characterDetailsVC.name = name[indexPath.row] //передаем индекс текущей строки
    }
    
   /*
    // MARK: - IB Actions
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: myPokemon?.next)
        : fetchData(from: myPokemon?.previous)
    }
    */
    
    
    
    
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    
    
    
    
    private func fetchData(from url: URL?) {
        networkManager.fetch(PokemonApp.self, from: url) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.myPokemon = pokemon
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    
    
}

// MARK: - UITableViewDataSource
extension CharactersTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        pokemonsMock.count
//        isFiltering ? filteredPokemon.count : myPokemon?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredPokemon.count : myPokemon?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        let pokemon = (isFiltering
        ? filteredPokemon[indexPath.row]
        : myPokemon?.results[indexPath.row])
        cell.configure(with: pokemon)
        return cell
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUI", for: indexPath)
//        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
//        let pokemon = (isFiltering
//                       ? filteredPokemon[indexPath.row]
//                       : myPokemon?.results[indexPath.row])!
//        cell.configure(with: pokemon)
//        return cell
        
        
        
    }
    
    
    
}

// MARK: - UISearchResultsUpdating
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPokemon = myPokemon?.results.filter { pokemon in
            pokemon.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
