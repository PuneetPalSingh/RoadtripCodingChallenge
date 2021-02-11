//
//  NetworkClient.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import Foundation
import Alamofire

final class NetworkClient {
    public static let shared = NetworkClient()
    public var authenticationType: AuthenticationType
    private var headers :HTTPHeaders? = [
        "Content-Type": "application/json"
    ]
    
    init() {
        self.authenticationType = .AuthenticationNonType
    }
    
    // MARK: - Public
    public func get(urlPath: String?, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        requestWithUrlPath(urlPath: urlPath, method: .get, parameters: parameters, complitionHandler: complitionHandler)
    }
    
    public func post(urlPath: String?, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        requestWithUrlPath(urlPath: urlPath, method: .post, parameters: parameters, complitionHandler: complitionHandler)
    }
    
    public func patch(urlPath: String?, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        requestWithUrlPath(urlPath: urlPath, method: .patch, parameters: parameters, complitionHandler: complitionHandler)
    }
    
    public func put(urlPath: String?, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        requestWithUrlPath(urlPath: urlPath, method: .put, parameters: parameters, complitionHandler: complitionHandler)
    }
    
    public func delete(urlPath: String?, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        requestWithUrlPath(urlPath: urlPath, method: .delete, parameters: parameters, complitionHandler: complitionHandler)
    }
    
    @discardableResult public func setAuthToken(authToken: String?) -> Bool {
        guard let authToken = authToken, authToken != "" else {
            print(NSError.init(domain: kBundleId, code: 1, userInfo: ["description": "Invalide Authentication Token"]))
            return false
        }
        if authenticationType == .AuthenticationSpotifyType {
            headers?.add(HTTPHeader.init(name: "Authorization", value: "Bearer \(authToken)"))
            return true
        }
        return false
    }
    
    public func removeAuthToken() {
        if authenticationType == .AuthenticationSpotifyType {
            headers?.remove(name: "Authorization")
        }
        self.authenticationType = .AuthenticationNonType
    }
    
    // MARK: - Healpers
    private func requestWithUrlPath(urlPath: String?, method: HTTPMethod, parameters: Dictionary<String,Any>?, complitionHandler: @escaping (Result<AnyObject?, Error>) -> Void) {
        guard let urlPath = urlPath,
            urlPath != "" else {
            return complitionHandler(.failure(NSError.init(domain: kBundleId, code: 400, userInfo: ["description": "Please add valid url path"])))
        }
        let request = AF.request(kBaseURL + urlPath, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        request.responseJSON { (data) in
            switch data.result {
            case .success(let data):
                complitionHandler(.success(data as AnyObject))
            case .failure(let orignalError as NSError):
                let error = NSError.init(domain: kBundleId, code: orignalError.code, userInfo: orignalError.userInfo)
                print(request.cURLDescription())
                complitionHandler(.failure(error))
            }
        }
    }
}
