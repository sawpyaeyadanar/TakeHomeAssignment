//
//  OverlayLoadingView.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/19/22.
//

import Foundation
import UIKit
class OverlayLoadingView: UIView {

    private var currentProcess = 0

    static let shared = OverlayLoadingView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {

        self.backgroundColor = UIColor.black.withAlphaComponent(0.2) // 20% TRANSPARANCE LAYER
        self.isUserInteractionEnabled = true // ACCEPT USER INTERATION TO FILTER USER ACTION AND GESTURE FOR ALL CHILD VIEW

        let activityInticator = UIActivityIndicatorView(style: .large)
        activityInticator.center = self.center
        activityInticator.startAnimating()

        self.addSubview(activityInticator)
    }

    func show() {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }

        currentProcess += 1

        // REMOVE PREVIOUS LOADING VIEW FROM KEY WINDOWS
        for subView in window.subviews {
            if let overlayLoadingView = subView as? OverlayLoadingView {
                DispatchQueue.main.async() {
                    UIView.animate(withDuration: 0.3, animations: {
                        overlayLoadingView.alpha = 0
                    }, completion: { (complete) in
                        overlayLoadingView.removeFromSuperview()
                    })
                }
            }
        }

        // ADD NEW OVERLAY LOADING VIEW
        let overlayLoadingView = OverlayLoadingView(frame: window.bounds)
        window.addSubview(overlayLoadingView)

    }

    func hide() {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        currentProcess -= 1
        //currentProcess = currentProcess < 0 ? 0 : currentProcess
        guard currentProcess == 0 else {
            currentProcess = currentProcess < 0 ? 0 : currentProcess
            return
        }

        // REMOVE ALL OVERLAY LOADING VIEW
        for subView in window.subviews {
            if let overlayLoadingView = subView as? OverlayLoadingView {
                DispatchQueue.main.async() {
                    UIView.animate(withDuration: 0.3, animations: {
                        overlayLoadingView.alpha = 0
                    }, completion: { (complete) in
                        overlayLoadingView.removeFromSuperview()
                    })
                }
            }
        }
    }
}
