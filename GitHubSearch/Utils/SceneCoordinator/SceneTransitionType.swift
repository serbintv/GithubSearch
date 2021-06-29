//
//  SceneTransitionType.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

enum SceneTransitionType {
    case root(UIViewController)       //  make view controller the root view controller.
    case push(UIViewController)       //  push view controller to navigation stack.
    case present(UIViewController)    //  present view controller.
    case alert(UIViewController)      //  present alert.
    case replace(UIViewController)
    case goTo(Int, Bool)
    case none
}

