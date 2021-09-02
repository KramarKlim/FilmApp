//
//  FilmCollectionViewCell.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    var model: FilmModelProtocol! {
        didSet {
            titleLabel.text = model.getTitle()
            dateLabel.text = model.getDate()
            filmImage.fetchImage(from: model.getImage())
            filmImage.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var filmImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
}
