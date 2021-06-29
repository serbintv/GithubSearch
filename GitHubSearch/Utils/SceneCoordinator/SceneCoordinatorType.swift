//
//  SceneCoordinatorType.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation

import UIKit

protocol SceneCoordinatorType {
    init(window: UIWindow)

    func transition(to scene: TargetScene)
    func pop(animated: Bool, toRoot: Bool, completion:(() -> Void)?)
}
