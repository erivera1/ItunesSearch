//
//  ViewControllerExtension.swift
//  News
//
//  Created by Eliric Rivera on 27/02/2019.
//  Copyright © 2019 Eliric Rivera. All rights reserved.
//


import UIKit
extension UIViewController {
    func presentAlert(message: String, onOk: @escaping ()->Void = { }) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) {
            _ in
            onOk()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
