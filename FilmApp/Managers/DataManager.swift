//
//  DataManager.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    var favourite = Set<Int>()
    
    private let webString = "https://api.themoviedb.org/3/"
    
    private let keyString = "?api_key=b20dda5a33582cd5efa3a442b91f10ec"
    
    private init() {}
    
    func getShowList(show: CurrentShow) -> String {
        switch show {
        case .film:
            return webString + "discover/movie" + keyString
        case .serial:
            return webString + "discover/tv" + keyString
        }
    }
    
    func getDetail(detail: CurrentShow, id: Int) -> String {
        switch detail {
        case .film:
            return webString + "movie/\(id)" + keyString
        case .serial:
            return webString + "tv/\(id)" + keyString
        }
    }
    
    func getActor(detail: CurrentShow,id: Int) -> String {
        switch detail {
        case .film:
            return webString + "movie/\(id)/credits" + keyString
        case .serial:
            return webString + "tv/\(id)/credits" + keyString
        }
    }
    
    func getURL(number: Int) -> String {
        "https://image.tmdb.org/t/p/w\(number)"
    }
    
    func getError(error: Error) -> String {
        switch error {
        case .image:
            return "https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png"
        case .web:
            return "https://www.themoviedb.org"
        }
    }
}
