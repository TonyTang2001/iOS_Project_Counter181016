//
//  CountBtn.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/5.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

//MARK: - NumberLb
class CountDisplay: SpringLabel, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.textColor = theme.countDisplayColor
        self.backgroundColor = theme.backgroundColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Buttons
class SuperBtn: UIButton, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.setTitleColor(self.themeTextColor(theme: theme), for: .normal)
        self.backgroundColor = self.themebgColor(theme: theme)
    }
    
    func themeTextColor(theme:ThemeProtocol) -> UIColor {
        return theme.backgroundColor
    }
    
    func themebgColor(theme:ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class CountBtn: SuperBtn {
    override func themeTextColor(theme:ThemeProtocol) -> UIColor {
        return theme.countBtnColor
    }
    
    override func themebgColor(theme: ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
}

class AntiCountBtn: SuperBtn {
    override func themeTextColor(theme:ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
    
    override func themebgColor(theme: ThemeProtocol) -> UIColor {
        return theme.backgroundColor
    }
}

class NaviBtn: SuperBtn {
    override func themeTextColor(theme:ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
    
    override func themebgColor(theme: ThemeProtocol) -> UIColor {
        return theme.backgroundColor
    }
}

class MultiModeBtn: VKExpandableButton, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.textColor = theme.backgroundColor
        self.expandedTextColor = theme.backgroundColor
        self.buttonBackgroundColor = theme.mainColor
        self.expandedButtonBackgroundColor = theme.mainColor
        self.selectionColor = UIColor.white.withAlphaComponent(0.3)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SettingsBtn: UIButton, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.tintColor = theme.mainColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class VersionDisplayLb: UILabel, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.textColor = theme.subLabelColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class DevNameLb: UILabel, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
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
        self.textColor = theme.subLabelColor.withAlphaComponent(0.3)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
