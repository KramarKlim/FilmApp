//
//  ActorsModel.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation

protocol ActorsModelProtocol {
    var actor: Cast? { get }
    
    init(actor: Cast?)
    
    func getImage() -> String
    func getName() -> String
    func getCharacter() -> String
}

class ActorsModel: ActorsModelProtocol {
    var actor: Cast?
        
    required init(actor: Cast?) {
        self.actor = actor
    }
    
    func getImage() -> String {
        guard let string = actor?.profile_path else { return DataManager.shared.getError(error: .image)}
        return DataManager.shared.getURL(number: 200) + string
    }
    
    func getName() -> String {
        actor?.name ?? "Неизвестно"
    }
    
    func getCharacter() -> String {
        actor?.job ?? "Неизвестно"
    }
}
