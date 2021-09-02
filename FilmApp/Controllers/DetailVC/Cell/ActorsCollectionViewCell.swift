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
            if !isReuse {
                setup()
            }
            actorImage.fetchImage(from: model.getImage())
            nameLabel.text = model.getName()
            characterLabel.text = model.getCharacter()
        }
    }
    
    override func prepareForReuse() {
        actorImage.image = nil
    }
    
    private var isReuse = false
    
    @IBOutlet var actorImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    private func setup() {
        isReuse = true
        actorImage.clipsToBounds = true
        actorImage.layer.cornerRadius = 10
    }
}
