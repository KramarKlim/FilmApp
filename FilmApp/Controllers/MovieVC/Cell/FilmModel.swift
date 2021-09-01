//
//  FilmModel.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

protocol FilmModelProtocol {
    var film: Result { get }
    
    init(film: Result)
    
    func getImage() -> String
    func getTitle() -> String
    func getDate() -> String
}

class FilmModel: FilmModelProtocol {
    var film: Result
    
    required init(film: Result) {
        self.film = film
    }
    
    func getImage() -> String {
        return DataManager.shared.imageURL + (film.poster_path ?? "-")
    }
    
    func getTitle() -> String {
        film.title ?? "Неизвестно"
    }
    
    func getDate() -> String {
        film.release_date?.convertDateFormater() ?? "Отсутствует"
        
    }
}
