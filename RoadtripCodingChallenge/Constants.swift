//
//  Constants.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/23/20.
//

import Foundation

let kBaseURL: String = "https://api.spotify.com/v1"
let kKeyChainAuthTokenKey = "Session Auth Token"
let kKeyChainUserDataKey = "Session User Data"
let kAuthenticationTypeKey = "Session Type"

let kBundleId: String = Bundle.main.bundleIdentifier!
let kAppVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
