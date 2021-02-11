//
//  BookmarkViewModel.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/28/20.
//

import Foundation

protocol BookmarkViewModelProtocol: class {
    var view: BookmarkViewProtocol? { get set}
    func viewDidLoad()
}

class BookmarkViewModel {
    weak var view: BookmarkViewProtocol?
    init(view: BookmarkViewProtocol) {
        self.view = view
    }
}

extension BookmarkViewModel: BookmarkViewModelProtocol {
    func viewDidLoad() {
        
    }
}
