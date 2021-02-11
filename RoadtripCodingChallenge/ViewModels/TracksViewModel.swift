//
//  TracksViewModel.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/28/20.
//

import Foundation

protocol TracksViewModelProtocol: class {
    var view: TracksViewProtocol? {get set}
    var tracks: [Track]? {get}
    var filteredTracks: [Track]? {get}
    func viewDidLoad()
    func filterContentForSearchText(_ searchText: String)
}

class TracksViewModel: TracksViewModelProtocol {
    weak var view: TracksViewProtocol?
    var tracks: [Track]?
    var filteredTracks: [Track]?
    init(view: TracksViewProtocol?) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetch()
    }
    
    private func fetch() {
        fetchNewReleaseTracks { [weak self] (result) in
            switch result {
            case .success(let tracks):
                self?.tracks = tracks
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.showErrorLoadingTracks(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func fetchNewReleaseTracks(complitionHandler: @escaping (Result<[Track],Error>) -> Void)  {
        NetworkClient.shared.get(urlPath: "/browse/new-releases", parameters: nil) { (result) in
            switch result {
            case .success(let response):
                if let error = response!["error"] as? Dictionary<String,AnyObject> {
                    let error = NSError.init(domain: kBundleId, code: error["status"] as! Int, userInfo: error)
                    complitionHandler(.failure(error))
                }
                else {
                    let jsonData: Data = try! JSONSerialization.data(withJSONObject: response!["albums"] as Any)
                    let album: Album = try! JSONDecoder().decode(Album.self, from: jsonData)
                    complitionHandler(.success(album.items ?? []))
                }
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredTracks = (tracks?.filter { (track: Track) -> Bool in
            return (track.name?.lowercased().contains(searchText.lowercased()))!
        })!
        view?.reloadData()
    }
}

