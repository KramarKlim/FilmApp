//
//  MovieListViewController.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import UIKit

class MovieListViewController: UIViewController {
    var model: MovieModelProtocol!
    
    @IBOutlet var filmListCollectionView: UICollectionView!
    @IBOutlet var serialListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = MovieModel()
        setupCollectionView()
        fetchRequest()
        self.navigationController?.navigationBar.topItem?.title = "KLIM"
}
    
    private func setupCollectionView() {
        filmListCollectionView.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "film")
        serialListCollectionView.register(UINib(nibName: "SerialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serial")
        
        filmListCollectionView.delegate = self
        filmListCollectionView.dataSource = self
        
        serialListCollectionView.delegate = self
        serialListCollectionView.dataSource = self
    }
    
    private func fetchRequest() {
        model.fetchRequestForFilm {
            DispatchQueue.main.async {
                self.filmListCollectionView.reloadData()
            }
        }
        model.fetchRequestForSerials {
            DispatchQueue.main.async {
                self.serialListCollectionView.reloadData()
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filmListCollectionView: return model.numberOfCells(type: .film)
        case serialListCollectionView: return model.numberOfCells(type: .serial)
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case filmListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "film", for: indexPath) as! FilmCollectionViewCell
            let film = model.filmModel(type: .film, indexPath: indexPath)
            cell.model = film
            return cell
        case serialListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serial", for: indexPath) as! SerialCollectionViewCell
            let serial = model.filmModel(type: .serial, indexPath: indexPath)
            cell.model = serial
            return cell
        default: return UICollectionViewCell()
        }
    }
}
