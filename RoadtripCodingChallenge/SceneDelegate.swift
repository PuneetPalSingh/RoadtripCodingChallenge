//
//  SceneDelegate.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/22/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        SPTAppRemote.checkIfSpotifyAppIsActive({ (success) in
            if (success) {
                // Prompt the user to connect Spotify here
            }
        })
        
        let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        let view2 = UIView(frame: CGRect(x: 99, y: 100, width: 100, height: 100))
        
        func checkIfViewsOverplay(view1: UIView, view2: UIView) -> Bool {
            if (view2.frame.origin.x >= view1.frame.origin.x && view2.frame.origin.x <= view1.frame.origin.x + view1.frame.size.width) && (view2.frame.origin.y >= view1.frame.origin.y && view2.frame.origin.y <= view1.frame.origin.y + view1.frame.size.height) {
                return true
            }
            else if (view1.frame.origin.x >= view2.frame.origin.x && view1.frame.origin.x <= view2.frame.origin.x + view2.frame.size.width) && (view1.frame.origin.y >= view2.frame.origin.y && view1.frame.origin.y <= view2.frame.origin.y + view2.frame.size.height){
                return true
            }
            return false
        }
        let check = checkIfViewsOverplay(view1: view1, view2: view2)
        
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            self.window?.rootViewController = LoginViewController.controller()
            self.window?.makeKeyAndVisible()
//            AuthManager.sharedManager.removeSessionFromKeychain()
            if AuthManager.sharedManager.restoreSessionFromKeychain() {
                let tabBarController = UITabBarController.init()
                let songsVC = TracksViewController.controller()
                let songsNavigationController = UINavigationController.init(rootViewController: songsVC)
                let bookmarkVC = BookmarkViewController.controller()
                let bookmarkNavigationController = UINavigationController.init(rootViewController: bookmarkVC)
                tabBarController.viewControllers = [songsNavigationController, bookmarkNavigationController]
                tabBarController.modalPresentationStyle = .fullScreen
                self.window?.rootViewController?.present(tabBarController, animated: false, completion: nil)
                let songsTabBar: UITabBarItem = tabBarController.tabBar.items![0]
                songsTabBar.image = UIImage.init(named: "song-icon")
                let bookmarkTabBar: UITabBarItem = tabBarController.tabBar.items![1]
                bookmarkTabBar.image = UIImage.init(named: "star-icon")
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        SpotifyManager.shared.setToken(url: url)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

