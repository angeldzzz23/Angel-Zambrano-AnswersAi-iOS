//
//  SceneDelegate.swift
//  AppStore
//
//  Created by angel zambrano on 12/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        // 1. Create a new UIWindow and associate it with the UIWindowScene
        let window = UIWindow(windowScene: windowScene)

        // 2. Create a UITabBarController
        let tabBarController = UITabBarController()

        // 3. Add child view controllers
        let todayView = TodayViewController()
        todayView.tabBarItem = UITabBarItem(
            title: "Today",
            image: UIImage(named: "tabbar_today"), // Use fallback images here
            selectedImage: UIImage(named: "tabbar_today")
        )
        // Add more view controllers if needed
        tabBarController.viewControllers = [todayView]

        // 4. Set the UITabBarController as the root view controller
        window.rootViewController = tabBarController

        // 5. Make the window key and visible
        self.window = window
        window.makeKeyAndVisible()

        
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
    }


}

