//
//  MovieListModel.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

protocol MovieModelProtocol {
    var filmList: [Result] { get }
    var serialList: [Result] { get }
    
    func fetchRequestForFilm(completion: @escaping () -> Void)
    func fetchRequestForSerials(completion: @escaping () -> Void)
    func numberOfCells(type: CurrentShow) -> Int
    func filmModel(type: CurrentShow, indexPath: IndexPath) -> FilmModelProtocol?
    func detailModel(indexPath: IndexPath, show: CurrentShow) -> DetailModelProtocol?
}

class MovieModel: MovieModelProtocol {
    var filmList: [Result] = []
    
    var serialList: [Result] = []
    
    func fetchRequestForFilm(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNetwork(string: DataManager.shared.getShowList(show: .film), expecting: MovieType.self) { film in
            self.filmList = film.results ?? []
            completion()
        }
    }
    
    func fetchRequestForSerials(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNetwork(string: DataManager.shared.getShowList(show: .serial), expecting: MovieType.self) { serial in
            self.serialList = serial.results ?? []
            completion()
        }
    }
    
    func numberOfCells(type: CurrentShow) -> Int {
        switch type {
        case .film: return filmList.count
        case .serial: return serialList.count
        }
    }
    
    func filmModel(type: CurrentShow, indexPath: IndexPath) -> FilmModelProtocol? {
        switch type {
        case .film: return FilmModel(film: filmList[indexPath.row])
        case .serial: return SerialModel(film: serialList[indexPath.row])
        }
    }
    
    func detailModel(indexPath: IndexPath, show: CurrentShow) -> DetailModelProtocol? {
        switch show {
        case .film: return DetailModel(show: show, id: filmList[indexPath.row].id ?? 0)
        case .serial: return DetailModel(show: show, id: serialList[indexPath.row].id ?? 0)
        }
    }
}
