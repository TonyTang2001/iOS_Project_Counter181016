//
//  SettingsCell.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/18.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class SuperSettingsCell: UITableViewCell, ThemeManagerProtocol {
    //init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.changeTheme()
    }
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)),
                                               name: ThemeNotifacationName,
                                               object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else { return }
        self.textLabel?.textColor = theme.mainColor
        let selectionColor = UIView()
        selectionColor.backgroundColor = theme.cellSelectionColor
        self.selectedBackgroundView = selectionColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SuperSettingsSwt: UISwitch, ThemeManagerProtocol {
    //init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.changeTheme()
    }
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)),
                                               name: ThemeNotifacationName,
                                               object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else { return }
        self.onTintColor = theme.mainColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
