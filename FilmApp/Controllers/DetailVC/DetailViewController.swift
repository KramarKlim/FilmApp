//
//  DetailViewController.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model: DetailModelProtocol!
    
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var actorsCollectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var watchButton: UIButton!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var favouriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        watchButton.layer.cornerRadius = 10
        
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        actorsCollectionView.register(UINib(nibName: "ActorsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "actors")
        favouriteButton.image = model.favouriteImage()
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteButton.image = model.saveImage(image: favouriteButton.image!)
    }
    
    
    @IBAction func watchButtonAction(_ sender: UIButton) {
        present(model.searchWeb(), animated: true)
    }
    
    
    private func setupCollectionView() {
        model.fetchRequestForActor { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.actorsCollectionView.reloadData()
            }
        }
    }
    
    private func setupView() {
        model.fetchRequest { [weak self] in
            guard let self = self else { return }            
            DispatchQueue.main.async {
                self.ratingLabel.text = self.model.getRating()
                self.descLabel.text = self.model.getDesc()
                self.showImage.fetchImage(from: self.model.getImage())
                self.titleLabel.text = self.model.getTitle()
                self.genreLabel.text = self.model.getGenreYear()
                self.showImage.applyGradient()
            }
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberOfCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actors", for: indexPath) as! ActorsCollectionViewCell
        let actor = model.actorsModel(indexPath: indexPath)
        cell.model = actor
        return cell
    }
}
