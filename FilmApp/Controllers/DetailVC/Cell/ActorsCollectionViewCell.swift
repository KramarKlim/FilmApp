//
//  ActorsCollectionViewCell.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    
    var model: ActorsModelProtocol! {
        didSet {
            actorImage.fetchImage(from: model.getImage())
            nameLabel.text = model.getName()
            characterLabel.text = model.getCharacter()
            actorImage.layer.cornerRadius = 26
            actorImage.clipsToBounds = true
        }
    }
    @IBOutlet var actorImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
}
