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
        guard let string = film.poster_path else { return DataManager.shared.getError(error: .image)}
        return DataManager.shared.getURL(number: 200) + (string)
    }
    
    func getTitle() -> String {
        film.original_name ?? "Неизвестно"
    }
    
    func getDate() -> String {
        film.first_air_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMM dd, yyyy") ?? "Отсутствует"
    }
}
