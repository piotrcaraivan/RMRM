//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Петр Караиван on 10.03.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        let viewModel = CharactersViewModel(networkManager: NetworkManager(), firebaseManager: FirebaseManager())
        let viewController = CharactersViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
