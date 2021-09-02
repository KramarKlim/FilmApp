//
//  MovieListViewController.swift
//  FilmApp
//
//  Created by Клим on 31.08.2021.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //MARK: Public Property
    var model: MovieModelProtocol!
    
    
    //MARK: IBOutlets
    @IBOutlet var filmListCollectionView: UICollectionView!
    @IBOutlet var serialListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = MovieModel()
        setupCollectionView()
        fetchRequest()
        self.navigationController?.navigationBar.topItem?.title = "KLIM"

    }
    
    //MARK: Private Methods
    private func setupCollectionView() {
        filmListCollectionView.register(UINib(nibName: "FilmCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "film")
        serialListCollectionView.register(UINib(nibName: "SerialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serial")
        
        filmListCollectionView.delegate = self
        filmListCollectionView.dataSource = self
        
        serialListCollectionView.delegate = self
        serialListCollectionView.dataSource = self
    }
    
    private func fetchRequest() {
        model.fetchRequestForFilm { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.filmListCollectionView.reloadData()
            }
        }
        model.fetchRequestForSerials { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.serialListCollectionView.reloadData()
            }
        }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch collectionView {
        case filmListCollectionView:
            let detailModel = model.detailModel(indexPath: indexPath, show: .film)
            performSegue(withIdentifier: "detail", sender: detailModel)
        case serialListCollectionView:
            let detailModel = model.detailModel(indexPath: indexPath, show: .serial)
            performSegue(withIdentifier: "detail", sender: detailModel)
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.model = sender as? DetailModelProtocol
        navigationItem.backButtonTitle = ""
    }
}
