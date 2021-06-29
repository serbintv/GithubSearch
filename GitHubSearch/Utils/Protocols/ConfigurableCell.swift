//
//  TableViewDataSource.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

protocol ConfigurableCell: NibLoadableView {
    associatedtype T
    func configure(_ item: T, at indexPath: IndexPath)
}


protocol NibLoadableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
