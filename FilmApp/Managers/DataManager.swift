//
//  DataManager.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

class DataManager {
     static let shared = DataManager()
    
    private init() {}
    
    func getShowList(show: CurrentShow) -> String {
        switch show {
        case .film: return "https://api.themoviedb.org/3/discover/movie?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        case .serial: return "https://api.themoviedb.org/3/discover/tv?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        }
    }
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
}
