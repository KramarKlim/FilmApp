//
//  DetailType.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation

struct DetailType: Codable {
    let backdrop_path: String?
    let genres: [Genre]?
    let overview: String?
    let title: String?
    let vote_average: Double?
    let name: String?
    let id: Int?
    let release_date: String?
    let first_air_date: String?
    let homepage: String?
}

struct Genre: Codable {
    let name: String?
}
