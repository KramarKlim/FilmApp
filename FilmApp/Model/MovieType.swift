//
//  MovieModel.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import Foundation

struct MovieType: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let poster_path: String?
    let title: String?
    let release_date: String?
    let id: Int?
    let first_air_date: String?
    let original_name: String?
}
