//
//  SceneCoordinator.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

class SceneCoordinator: NSObject, SceneCoordinatorType {

    static var shared: SceneCoordinator!

    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController {
        didSet {
            currentViewController.navigationController?.delegate = self
            currentViewController.tabBarController?.delegate = self
        }
    }

    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController!
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController

            return actualViewController(for: controller)
        }

        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.last!

            return actualViewController(for: controller)
        }
        return controller
    }

    func transition(to scene: TargetScene) {

        switch scene.transition {
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
        case let .present(viewController):
            currentViewController.navigationController?.present(viewController, animated: true)
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        case let .push(viewController):
            guard let navigationController = currentViewController.navigationController else {
                return
            }

            navigationController.pushViewController(SceneCoordinator.actualViewController(for: viewController),
                                                    animated: true)
        case let .goTo(item, goToRoot):
            guard let tabBarController = window.rootViewController as? UITabBarController else {
                return
            }

            tabBarController.selectedIndex = item
            currentViewController = SceneCoordinator.actualViewController(for: tabBarController.viewControllers![item])
            if goToRoot {
                currentViewController.navigationController?.popToRootViewController(animated: false)
            }

        case let .replace(viewController):
            guard let navigationController = (window.rootViewController as? UITabBarController)?
                    .viewControllers?.last as? UINavigationController else {
                fatalError("Can't replace a view controller without a current navigation controller")
            }
            navigationController.setViewControllers([viewController], animated: false)

        case .alert, .none:
            break
        }
    }

    func pop(animated: Bool, toRoot: Bool = false, completion:(() -> Void)? = nil) {

        if let presentingViewController = currentViewController.presentingViewController {
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                completion?()
            }
        } else if let presentedViewController = currentViewController.presentedViewController {
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentedViewController)
                completion?()
            }
            
        } else if let navigationController = currentViewController.navigationController {
            if navigationController.viewControllers.count > 1 {
                if toRoot == false {
                    guard navigationController.popViewController(animated: animated) != nil else {
                        fatalError("can't navigate back from \(currentViewController)")
                    }
                    currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
                } else {
                    navigationController.popToRootViewController(animated: animated)
                    currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
                }
            }
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
    }

    func didCloseGallery() {
        if let presentingViewController = currentViewController.presentingViewController {
            self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
        }
    }

}

// MARK: - UINavigationControllerDelegate
extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}

// MARK: - UITabBarControllerDelegate
extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController != tabBarController.selectedViewController
    }

}
