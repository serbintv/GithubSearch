//
//  KeyboardObservable.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

protocol KeyboardObservable: AnyObject {
    var showObserver: NSObjectProtocol? { get set }
    var hideObserver: NSObjectProtocol? { get set }

    var showBlock: ((Notification) -> Void)? { get set }
    var hideBlock: ((Notification) -> Void)? { get set }

    func configureKeyboardListener()
    func setupKeyboardObserver()
}

extension KeyboardObservable where Self: UIViewController {
    func configureKeyboardListener() {
        guard let show = showBlock,
              let hide = hideBlock
        else {
            return
        }
        showObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: nil, using: show)

        hideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: nil, using: hide)
    }
}
