//
//  SpotifyManager.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/22/20.
//

import Foundation

protocol SpotifyManagerLoginProtocol: AnyObject {
    func spotifyManagerSuccess(accessToken: String)
    func spotifyManagerFail(error: Error)
}

class SpotifyManager: NSObject {
    static let shared = SpotifyManager()
    private let SpotifyClientID = "1339928e4f5f45ea61f9a899fc40bdd"
    private let SpotifyRedirectURL = URL(string: "roadtripCodingChallenge://callback")!
    private var sessionManager: SPTSessionManager?
    private var appRemote: SPTAppRemote?
    private lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    
    weak var delegate: SpotifyManagerLoginProtocol?
    
    func signInWithSpotify() {
        configuration.playURI = ""
        sessionManager = SPTSessionManager.init(configuration: configuration, delegate: self)
        sessionManager?.initiateSession(with: SPTScope.init(arrayLiteral: [.appRemoteControl, .playlistReadPrivate, .streaming, .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying, .userReadRecentlyPlayed, .userReadPrivate, .userTopRead, .userReadPrivate, .userReadEmail, .userLibraryRead]), options: .clientOnly)
        appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote?.delegate = self;
    }
    
    func setToken(url: URL) {
        sessionManager?.application(UIApplication.shared, open: url, options: [:])
//        let parameters = appRemote?.authorizationParameters(from: url);
//
//        if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
//            appRemote?.connectionParameters.accessToken = access_token
////            delegate?.spotifyManagerSuccess(accessToken: access_token)
//        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            print(error_description)
//        }
    }
}

extension SpotifyManager: SPTSessionManagerDelegate {
    // MARK: Session Delegate Methods
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote?.connectionParameters.accessToken = session.accessToken
        appRemote?.connect()
    }
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        delegate?.spotifyManagerFail(error: error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("renewed", session)
    }
}

extension SpotifyManager: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("Connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Not Connected")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Not Connected")
    }
    
    
}
