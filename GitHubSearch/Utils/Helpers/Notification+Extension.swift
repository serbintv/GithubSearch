//
//  Notification+Extension.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

extension Notification {
    func getKeyboardHeight() -> CGFloat {
        guard let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return 0
        }

        let extraSpace: CGFloat = 0
        return keyboardFrame.cgRectValue.height + extraSpace
    }
}
