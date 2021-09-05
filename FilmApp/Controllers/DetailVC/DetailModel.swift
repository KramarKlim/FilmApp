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
    func ratingStars() -> [UIImage]
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
            self.actor = cast.cast ?? []
            completion()
        }
    }
    
    func numberOfCell() -> Int {
        actor.count
    }
    
    func getGenreYear() -> String {
        switch show {
        case .film:
            return (detail?.release_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "YYYY") ?? "Неизвестно") + " • " + (detail?.genres?.first?.name ?? "Неизвестно") + " • " + (detail?.runtime?.minutesToHoursAndMinutes() ?? "Неизвестно")
        case .serial:
            return (detail?.first_air_date?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "YYYY") ?? "Неизвестно") + " • " + (detail?.genres?.first?.name ?? "Неизвестно") + " • " + "Seasons: \(detail?.number_of_seasons?.description ?? "Неизвестно")"
        }
    }
    
    func getTitle() -> String {
        switch show {
        case .film:
            return detail?.title ?? "Неизвестно"
        case .serial:
            return detail?.name ?? "Неизвестно"
        }
    }
    
    func getRating() -> String {
        guard let rating = detail?.vote_average else { return "Неизвестно"}
        return rating.description
    }
    
    func getDesc() -> String {
        detail?.overview ?? "Неизвестно"
    }
    
    func getImage() -> String {
        guard let string = detail?.backdrop_path else { return DataManager.shared.getError(error: .image) }
        return DataManager.shared.getURL(number: 500) + (string)
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
        guard let heart = UIImage(systemName: "heart") else { return #imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")}
        guard let heartFill = UIImage(systemName: "heart.fill") else { return #imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")}
        if DataManager.shared.favourite.contains(id) {
            return  heartFill
        }
        return heart
    }
    
    func saveImage(image: UIImage) -> UIImage {
        guard let heart = UIImage(systemName: "heart") else { return #imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")}
        guard let heartFill = UIImage(systemName: "heart.fill") else { return #imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")}
        if image == heart {
            DataManager.shared.favourite.insert(id)
            return heartFill
        } else if image == heartFill {
            DataManager.shared.favourite.remove(id)
            return heart
        }
        return #imageLiteral(resourceName: "3126608")
    }
    
    func ratingStars() -> [UIImage] {
        let number = ((detail?.vote_average ?? 0.0) / 2)
        guard let imageEmpty = UIImage(systemName: "star") else { return [#imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")]}
        guard let imageFull = UIImage(systemName: "star.fill") else { return [#imageLiteral(resourceName: "png-clipart-warning-icon-error-computer-icons-orange-error-icon-miscellaneous-angle-thumbnail")]}
        switch number {
        case 0.0...0.99:
            return [imageEmpty, imageEmpty, imageEmpty, imageEmpty, imageEmpty]
        case 1.0...1.99:
            return [imageFull, imageEmpty, imageEmpty, imageEmpty, imageEmpty]
        case 2.0...2.99:
            return [imageFull, imageFull, imageEmpty, imageEmpty, imageEmpty]
        case 3.0...3.99:
            return [imageFull, imageFull, imageFull, imageEmpty, imageEmpty]
        case 4.0...4.99:
            return [imageFull, imageFull, imageFull, imageFull, imageEmpty]
        case 5.0:
            return [imageFull, imageFull, imageFull, imageFull, imageFull]
        default: break
        }
        return [imageEmpty]
    }
}
