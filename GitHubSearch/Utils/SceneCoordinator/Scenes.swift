//
//  Scenes.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit
import SafariServices

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case home
    case openUrl(URL)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .home:
            
            guard var homeViewController = UIStoryboard.getStoryboard(by: .home)
                    .instantiateInitialViewController() as? GithubProjectsViewController,
                let navigationController = UIStoryboard.getStoryboard(by: .root)
                    .instantiateInitialViewController() as? UINavigationController
            else {
                return .none
            }
            
            homeViewController.bind(to: GithubProjectsViewModel())
            navigationController.setViewControllers([homeViewController], animated: false)
            
            return .root(navigationController)
        case .openUrl(let url):
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url,
                                          options: [:],
                                          completionHandler: nil)
            }
            return .none
        }
    }
}
