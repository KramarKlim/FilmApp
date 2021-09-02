//
//  DetailModel.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import UIKit
import SafariServices

protocol DetailModelProtocol {
    var show: CurrentShow { get }
    var detail: DetailType? { get }
    var id: Int { get }
    var actor: [Cast] { get }
    
    init(show: CurrentShow, id: Int)
    
    func fetchRequest(completion: @escaping () -> Void)
    func numberOfCell() -> Int
    func getGenreYear() -> String
    func getTitle() -> String
    func getRating() -> String
    func getDesc() -> String
    func fetchRequestForActor(completion: @escaping () -> Void)
    func getImage() -> String
    func actorsModel(indexPath: IndexPath) -> ActorsModelProtocol?
    func searchWeb() -> SFSafariViewController
    func favouriteImage() -> UIImage
    func saveImage(image: UIImage) -> UIImage
}

class DetailModel: DetailModelProtocol {
        
    var show: CurrentShow
    
    var id: Int
    
    var detail: DetailType?
    
    var actor: [Cast] = []
        
    required init(show: CurrentShow, id: Int) {
        self.show = show
        self.id = id
    }
    
    func fetchRequest(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNetwork(string: DataManager.shared.getDetail(detail: show, id: id), expecting: DetailType.self) { info in
            self.detail = info
            completion()
        }
    }
    
    func fetchRequestForActor(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNetwork(string: DataManager.shared.getActor(detail: show, id: id), expecting: ActorType.self) { cast in
            self.actor = cast.crew ?? []
            completion()
        }
    }
    
    func numberOfCell() -> Int {
        actor.count
    }
    
    func getGenreYear() -> String {
        switch show {
        case .film:
            return (detail?.release_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "YYYY") ?? "Неизвестно") + ", " + (detail?.genres?.first?.name ?? "Неизвестно")
        case .serial:
            return (detail?.first_air_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "YYYY") ?? "Неизвестно") + ", " + (detail?.genres?.first?.name ?? "Неизвестно")
        }
    }
    
    func getTitle() -> String {
        switch show {
        case .film: return detail?.title ?? "Неизвестно"
        case .serial: return detail?.name ?? "Неизвестно"
        }
    }
    
    func getRating() -> String {
       return "\(detail?.vote_average ?? 0)"
    }
    
    func getDesc() -> String {
        detail?.overview ?? "Неизвестно"
    }
    
    func getImage() -> String {
         DataManager.shared.getURL(number: 500) + (detail?.backdrop_path ?? "Неизвестно")
    }
    
    func actorsModel(indexPath: IndexPath) -> ActorsModelProtocol? {
         ActorsModel(actor: actor[indexPath.row])
    }
    
    func searchWeb() -> SFSafariViewController {
        guard let string = detail?.homepage else { return SFSafariViewController(url: URL(string: DataManager.shared.getError(error: .web))!)}
        guard let url = URL(string: string) else { return SFSafariViewController(url: URL(string: DataManager.shared.getError(error: .web))!)}
        let homepage = SFSafariViewController(url: url)
        return homepage
    }
    
    func favouriteImage() -> UIImage {
        for images in DataManager.shared.favourite {
            if id == images {
                return  UIImage(systemName: "heart.fill")!
            }
        }
        return UIImage(systemName: "heart")!
    }
    
    func saveImage(image: UIImage) -> UIImage {
        if image == UIImage(systemName: "heart") {
            DataManager.shared.favourite.insert(id)
            return UIImage(systemName: "heart.fill")!
        } else if image == UIImage(systemName: "heart.fill")! {
            DataManager.shared.favourite.remove(id)
            return UIImage(systemName: "heart")!
        }
        return #imageLiteral(resourceName: "3126608")
    }
}
