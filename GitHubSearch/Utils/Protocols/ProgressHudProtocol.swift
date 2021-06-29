//
//  ProgressHudProtocol.swift
//  GitHubSearch
//
//  Created by Taras Serbin on 29.06.2021.
//

import Foundation
import SVProgressHUD

protocol ProgressHudProtocol {
    func show(text: String?)
    func close()
}

extension ProgressHudProtocol {
    func show(text: String? = nil) {
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = false
        configureColor()
        if let text = text {
            SVProgressHUD.show(withStatus: text)
        } else {
            SVProgressHUD.show()
        }
    }

    func showWith(status: String) {
        SVProgressHUD.showInfo(withStatus: status)
    }

    func showHudError(_ error: String) {
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.showError(withStatus: error)
    }

    func getProgressPoint() -> CGPoint {
        return SVProgressHUD.accessibilityActivationPoint()
    }

    func close() {
        UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
}

private extension ProgressHudProtocol {
    func configureColor() {
        SVProgressHUD.setForegroundColor(Color.blueColor)
    }
}
