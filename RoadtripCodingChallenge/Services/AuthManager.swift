//
//  AuthManager.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/23/20.
//

import Foundation
import SwiftKeychainWrapper

enum AuthenticationType: String {
    case AuthenticationNonType = "non"
    case AuthenticationSpotifyType = "spotify"
    case AuthenticationOtherType = "other"
}

protocol AuthManagerDelegate: class {
    func spotifySignInSuccess()
    func spotifySignInFail(error: Error)
}

final class AuthManager {
    private var authToken: String?
    private var authenticationType: AuthenticationType
    private var authTokenExpirationDate: Date?
    static let sharedManager = AuthManager()
    weak var delegate: AuthManagerDelegate?
    
    init() {
        self.authenticationType = .AuthenticationNonType
        SpotifyManager.shared.delegate = self
    }
    
    func signInWithSpotify() {
        SpotifyManager.shared.signInWithSpotify()
    }
    
    public func signOut(completionHandler: @escaping (Result<Bool,Error>) -> Void) {
        guard self.authToken != nil,
              self.authToken != "" else {
            return completionHandler(.failure(NSError.init(domain: kBundleId, code: 1, userInfo: ["description": "Unable to signout, Invalide Auth Token"])))
        }
        
        self.authToken = nil
        self.authenticationType = .AuthenticationNonType
        NetworkClient.shared.removeAuthToken()
        removeSessionFromKeychain()
        completionHandler(.success(true))
        print("Signing Out User")
    }
}

extension AuthManager: SpotifyManagerLoginProtocol {
    // MARK:- Spotify Manager delegate method
    func spotifyManagerSuccess(accessToken: String) {
        NetworkClient.shared.authenticationType = .AuthenticationSpotifyType
        NetworkClient.shared.setAuthToken(authToken: accessToken)
        self.authToken = accessToken
        self.authenticationType = .AuthenticationSpotifyType
        self.delegate?.spotifySignInSuccess()
        persistSessionToKeychain(authToken: accessToken)
        print("success", accessToken)
    }
    
    func spotifyManagerFail(error: Error) {
        self.delegate?.spotifySignInFail(error: error)
        print("fail", error)
    }
}

extension AuthManager {
    // MARK:- Persist Authentication Token To Keychain
    private func persistSessionToKeychain(authToken: String?) -> Void {
        guard let authToken = authToken else {
            return
        }
        KeychainWrapper.standard.set(authToken, forKey: kKeyChainAuthTokenKey)
        KeychainWrapper.standard.set(self.authenticationType.rawValue, forKey: kAuthenticationTypeKey)
    }
    
    func restoreSessionFromKeychain() -> Bool {
        guard let authToken = KeychainWrapper.standard.string(forKey: kKeyChainAuthTokenKey),
              let authenticationType = KeychainWrapper.standard.string(forKey: kAuthenticationTypeKey) else {
            return false
        }
        self.authToken = authToken
        self.authenticationType = AuthenticationType.init(rawValue: authenticationType) ?? .AuthenticationNonType
        NetworkClient.shared.authenticationType = self.authenticationType
        NetworkClient.shared.setAuthToken(authToken: authToken)
        return true
    }
    
    @discardableResult func removeSessionFromKeychain() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: kKeyChainAuthTokenKey)
    }
}
