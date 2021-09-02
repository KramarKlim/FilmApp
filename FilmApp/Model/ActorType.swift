//
//  ActorType.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation

struct ActorType: Codable {
    let crew: [Cast]?
}

struct Cast: Codable {
    let profile_path: String?
    let name: String?
    let job: String?
}
