//
//  ViewController.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/22/20.
//

import UIKit

protocol LoginViewProtocol: class {
    func showTabBarScreen()
    func showError(error: Error)
}
class LoginViewController: UIBaseViewController {
    @IBOutlet weak var imageView: UIImageView!
    private var loginViewModel: LoginViewModelProtocol?
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginViewModel?.loginButtonPressed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel(view: self)
        // Do any additional setup after loading the view.
    }
}

extension LoginViewController: LoginViewProtocol {
    func showTabBarScreen() {
        DispatchQueue.main.async { [weak self] in
            let tabBarController = UITabBarController.init()
            let songsVC = TracksViewController.controller()
            let songsNavigationController = UINavigationController.init(rootViewController: songsVC)
            let bookmarkVC = BookmarkViewController.controller()
            let bookmarkNavigationController = UINavigationController.init(rootViewController: bookmarkVC)
            tabBarController.viewControllers = [songsNavigationController, bookmarkNavigationController]
            tabBarController.modalPresentationStyle = .fullScreen
            self?.present(tabBarController, animated: false, completion: nil)
            let songsTabBar: UITabBarItem = tabBarController.tabBar.items![0]
            songsTabBar.image = UIImage.init(named: "song-icon")
            let bookmarkTabBar: UITabBarItem = tabBarController.tabBar.items![1]
            bookmarkTabBar.image = UIImage.init(named: "star-icon")
        }
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
