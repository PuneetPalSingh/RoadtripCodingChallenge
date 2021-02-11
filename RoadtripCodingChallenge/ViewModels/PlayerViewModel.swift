//
//  PlayerViewModel.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 12/2/20.
//

import Foundation

protocol PlayerViewModelProtocol: class {
    var view: PlayerViewProtocol? {get set}
    var track: Track? {get}
    func viewDidLoad()
}

class PlayerViewModel {
    weak var view: PlayerViewProtocol?
    var track: Track?
    init(view: PlayerViewProtocol, track: Track?) {
        self.view = view
        self.track = track
    }
}

extension PlayerViewModel: PlayerViewModelProtocol {
    func viewDidLoad() {
        
    }
}
