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
        guard let string = film.poster_path else { return DataManager.shared.getError(error: .image)}
        return DataManager.shared.getURL(number: 200) + (string)
    }
    
    func getTitle() -> String {
        film.title ?? "Неизвестно"
    }
    
    func getDate() -> String {
        film.release_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMM dd, yyyy") ?? "Отсутствует"
    }
}
