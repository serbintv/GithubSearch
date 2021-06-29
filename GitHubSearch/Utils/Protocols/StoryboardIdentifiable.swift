// 
//  StoryboardIdentifiable.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
