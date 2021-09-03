//
//  SerialCollectionViewCell.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import UIKit

class SerialCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Property
    var model: FilmModelProtocol! {
        didSet {
            titleLabel.text = model.getTitle()
            dateLabel.text = model.getDate()
            serialImage.fetchImage(from: model.getImage())
            serialImage.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var serialImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
}
