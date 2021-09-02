//
//  NetworkManager.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchNetwork<T: Codable>(string: String, expecting: T.Type, completion: @escaping (T)  -> Void) {
        guard let url = URL(string: string) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { print(error); return }
            if let response = response { print(response)}
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let cities = try decoder.decode(T.self, from: data)
                completion(cities)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
