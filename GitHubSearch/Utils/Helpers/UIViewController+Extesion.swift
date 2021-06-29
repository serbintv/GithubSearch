//
//  UIViewController+Extesion.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

extension UIViewController: StoryboardIdentifiable {

    // Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    func showAlert(withError error: Error?, isAutomaticallyDismissed: Bool = true) {

        guard let error = error  else {
            return
        }

        let alert = UIAlertController(title: alertTitleError,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: alertActionOk,
                                   style: .default,
                                   handler: nil)

        alert.addAction(action)

        if isAutomaticallyDismissed {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }

        if let presented  = presentedViewController {
            presented.dismiss(animated: false, completion: { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            })
        } else {
            present(alert, animated: true, completion: nil)
        }
    }

}

