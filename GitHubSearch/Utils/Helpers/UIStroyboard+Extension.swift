//
//  UIStroyboard+Extension.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

enum StoryboardName: String {
    case home = "Home"
    case root = "Root"
}

extension UIStoryboard {
    static func getStoryboard(by name: StoryboardName, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: bundle)
    }

    func instantiateViewController<VC: UIViewController>(from storyboardName: StoryboardName? = nil) -> VC {

        var storyboard: UIStoryboard?

        if let storyboardName = storyboardName {
            storyboard = UIStoryboard.getStoryboard(by: storyboardName)
        } else {
            storyboard = self
        }

        guard let viewController = storyboard?.instantiateViewController(withIdentifier: VC.storyboardIdentifier)
            as? VC else {
                fatalError("Couldn't instantiate view controller with identifier \(VC.storyboardIdentifier) ")
        }

        return viewController
    }
}
