//
//  CountBtn.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/5.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class CountBtn: UIButton, ThemeManagerProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.changeTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)),
                                               name: ThemeNotifacationName,
                                               object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        self.titleLabel?.textColor = self.themeTextColor(theme: theme)
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


//
//class antiCountBtn: UIButton, ThemeManagerProtocol {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.changeTheme()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func changeTheme() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)),
//                                               name: ThemeNotifacationName,
//                                               object: nil)
//        ThemeManager.themeUpdate()
//    }
//    
//    @objc func handelNotification(notification: NSNotification) {
//        guard let theme = notification.object as? ThemeProtocol else {
//            return
//        }
//        self.titleLabel?.textColor = self.themebgColor(theme: theme)
//        self.backgroundColor = self.themeTextColor(theme: theme)
//    }
//    
//    func themeTextColor(theme:ThemeProtocol) -> UIColor {
//        return theme.backgroundColor
//    }
//    
//    func themebgColor(theme:ThemeProtocol) -> UIColor {
//        return theme.mainColor
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//}

