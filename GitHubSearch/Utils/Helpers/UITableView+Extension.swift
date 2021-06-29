//
//  UITableView+Extension.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ : T.Type) where T: NibLoadableView {
     
            let bundle = Bundle(for: T.self)
            let nib = UINib(nibName: T.nibName, bundle: bundle)
            register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell & NibLoadableView>(for indexPath: IndexPath? = nil) -> T {
        
        if let indexPath = indexPath, let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
            }
            
            return cell
        }
    }
}
