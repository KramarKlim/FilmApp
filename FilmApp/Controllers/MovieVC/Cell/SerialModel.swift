//
//  SerialModel.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

class SerialModel: FilmModelProtocol {
    var film: Result
    
    required init(film: Result) {
        self.film = film
    }
    
    func getImage() -> String {
        return DataManager.shared.imageURL + (film.poster_path ?? "-")
    }
    
    func getTitle() -> String {
        film.original_name ?? "Неизвестно"
    }
    
    func getDate() -> String {
        film.first_air_date?.convertDateFormater() ?? "Отсутствует"
    }
    
    
}
