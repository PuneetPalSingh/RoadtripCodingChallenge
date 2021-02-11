//
//  LoginViewModel.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/23/20.
//

import Foundation

protocol LoginViewModelProtocol: class {
    var view: LoginViewProtocol? {get set}
    func loginButtonPressed()
}

class LoginViewModel: LoginViewModelProtocol {
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func loginButtonPressed() {
        AuthManager.sharedManager.delegate = self
        AuthManager.sharedManager.signInWithSpotify()
    }
}

extension LoginViewModel: AuthManagerDelegate {
    func spotifySignInSuccess() {
        view?.showTabBarScreen()
    }
    func spotifySignInFail(error: Error) {
        view?.showError(error: error)
    }
}
