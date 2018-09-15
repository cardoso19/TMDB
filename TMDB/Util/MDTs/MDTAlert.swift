//
//  MDTAlert.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class MDTAlert {
    static let shared: MDTAlert = MDTAlert()
    private weak var snackBar: SnackBarView?
    private init() {}
    //==--------------------------------==
    // MARK: - Snack Bar
    //==--------------------------------==
    public func showSnackBar(message: String, isError: Bool, dismissTime: TimeInterval = 3) {
        if let snack = self.snackBar {
            if snack.labelMessage.text != message {
                snackBar?.hide(canChangeWindowLevel: false)
                presentSnackBar(message: message, isError: isError, dismissTime: dismissTime)
            }
        } else {
            presentSnackBar(message: message, isError: isError, dismissTime: dismissTime)
        }
    }
    private func presentSnackBar(message: String, isError: Bool, dismissTime: TimeInterval) {
        if let window = UIApplication.shared.keyWindow {
            window.windowLevel = UIWindowLevelStatusBar
            if let snackBar: SnackBarView = SnackBarView.instanceFromNib(parentView: window,
                                                                      message: message,
                                                                      isError: isError,
                                                                      dismissTime: dismissTime) {
                snackBar.show()
                self.snackBar = snackBar
            }
        }
    }
}
