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
    
    let images: [UIImage?] = [UIImage(named: "heart")]
        
    private init() {}
    
    func getShowList(show: CurrentShow) -> String {
        switch show {
        case .film: return "https://api.themoviedb.org/3/discover/movie?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        case .serial: return "https://api.themoviedb.org/3/discover/tv?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        }
    }
    
    func getDetail(detail: CurrentShow, id: Int) -> String {
        switch detail {
        case .film: return "https://api.themoviedb.org/3/movie/\(id)?api_key=b20dda5a33582cd5efa3a442b91f10ec"
 //           https://api.themoviedb.org/3/movie/573164?api_key=b20dda5a33582cd5efa3a442b91f10ec
        case .serial: return "https://api.themoviedb.org/3/tv/\(id)?api_key=b20dda5a33582cd5efa3a442b91f10ec"
            //https://api.themoviedb.org/3/tv/91363?api_key=b20dda5a33582cd5efa3a442b91f10ec
        }
    }
    
    func getActor(detail: CurrentShow,id: Int) -> String {
        switch detail {
        case .film: return "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        case .serial: return "https://api.themoviedb.org/3/tv/\(id)/credits?api_key=b20dda5a33582cd5efa3a442b91f10ec"
        }
    }
    
    func getURL(number: Int) -> String {
        "https://image.tmdb.org/t/p/w\(number)"
    }
    
    func getError(error: Error) -> String {
        switch error {
        case .image: return "https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png"
        case .web: return "https://www.themoviedb.org"
        }
    }
}

