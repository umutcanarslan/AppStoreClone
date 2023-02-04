//
//  Hud.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import JGProgressHUD

class Hud {
    static var hud: JGProgressHUD?

    static func show(text: String? = nil) {
        if let old = hud {
            old.dismiss()
        }
        hud = JGProgressHUD(style: .dark)
        hud?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        hud?.textLabel.text = text
        if let currentView = UIApplication.shared.currentKeyWindow {
            hud?.show(in: currentView)
        }
    }

    static func dismiss() {
        hud?.dismiss()
        hud = nil
    }

    private init() {}
}
