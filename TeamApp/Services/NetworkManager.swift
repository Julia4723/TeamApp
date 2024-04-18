//
//  NetworkManager.swift
//  TeamApp
//
//  Created by user on 18.04.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum PokemonAPI: String {
    case baseURL = "https://pokeapi.co/api/v2/pokemon"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: String, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
                
            } catch {
                completion(.failure(.decodingError))
                
            }
            
        }.resume()
        
    }
    
    
    func fetchImage(from url: String, completion: @escaping(Data) -> Void) {
        
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
        
    }
    
   /*
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return

            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    */
}
