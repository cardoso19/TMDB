//
//  SnackBarView.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class SnackBarView: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var labelMessage: UILabel!

    // MARK: - Variables
    var dismissTime: TimeInterval = 3
    weak var delegate: AlertDelegate?
    weak var parentView: UIView?

    // MARK: - Init
    public class func instanceFromNib(parentView: UIView,
                                      message: String,
                                      isError: Bool,
                                      dismissTime: TimeInterval) -> SnackBarView? {
        if let view = UINib(nibName: "SnackBarView", bundle: nil).instantiate(withOwner: nil,
                                                                              options: nil).first as? SnackBarView {
            view.configLayout(isError: isError)
            view.dismissTime = dismissTime
            view.parentView = parentView
            view.labelMessage.text = message
            view.resizeView()
            parentView.addSubview(view)
            return view
        }
        return nil
    }
    func configLayout(isError: Bool) {
        if isError {
            backgroundColor = Colors.red
        } else {
            backgroundColor = Colors.darkGray
        }
    }

    // MARK: - IBActions
    @IBAction func actionTap(_ sender: UIButton) {
        hide(canChangeWindowLevel: true)
    }

    // MARK: - Interactions
    private func startTimer() {
        if dismissTime != 0 {
            Timer.scheduledTimer(timeInterval: dismissTime,
                                 target: self,
                                 selector: #selector(hide),
                                 userInfo: nil,
                                 repeats: false)
        }
    }

    func resizeView() {
        self.frame.size.width = UIScreen.main.bounds.size.width
        self.layoutIfNeeded()
        let verticalMargin: CGFloat = 20
        var newHeight: CGFloat = (labelMessage.text ?? "").height(withConstrainedWidth: labelMessage.frame.size.width,
                                                                  font: labelMessage.font) + verticalMargin
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            if let topPadding = window?.safeAreaInsets.top {
                newHeight += topPadding
            }
        }
        self.frame.size.height = max(newHeight, 50)
    }
}

// MARK: - AlertDelegate
extension SnackBarView: AlertDelegate {

    func show() {
        startTimer()
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: -self.frame.size.height)
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.frame.origin = CGPoint(x: self.frame.origin.x, y: 0)
        }, completion: nil)
    }

    @objc func hide(canChangeWindowLevel: Bool) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.frame.origin = CGPoint(x: self.frame.origin.x, y: -self.frame.size.height)
        }, completion: {(_) in
            if canChangeWindowLevel {
                UIApplication.shared.keyWindow!.windowLevel = UIWindow.Level.normal
            }
            self.removeFromSuperview()
        })
    }
}
