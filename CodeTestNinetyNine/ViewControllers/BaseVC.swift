//
//  BaseVC.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/19/22.
//

import Foundation
import UIKit
class BaseVC: UIViewController {
    func showNetworkError() {
        DispatchQueue.main.async {
            self.showAlert(title: "No Internet Connection", message: "Please check your Wi-Fi connection and mobile data.")
        }
    }

    func showAlert(title t: String,message m: String, completion: (() -> Void)? = nil)  {
      let controller = UIAlertController(title: t, message: m, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}
