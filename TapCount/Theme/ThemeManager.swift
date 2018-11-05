//
//  ThemeManager.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/4.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

let ThemeNotifacationName = NSNotification.Name("keyThemeNotifacation")

class ThemeManager: NSObject {
    
    var theme: ThemeProtocol = OrangeBlackTheme()   //Default
    
    static var manager: ThemeManager? = nil
    static func shareInstance() -> ThemeManager {
        if manager == nil {
            manager = ThemeManager()
        }
        return manager!
    }
    
    // MARK: - Switch Themes
    static func switcherTheme(type: ThemeType){
        ThemeManager.shareInstance().switcherTheme(type: type)
    }
    
    static func themeUpdate() {
        NotificationCenter.default.post(name: ThemeNotifacationName, object: ThemeManager.shareInstance().theme)
    }
    
    //MARK: - Private Method
    private override init() {}
    
    private func switcherTheme(type: ThemeType){
        self.theme = type.theme
        NotificationCenter.default.post(name: ThemeNotifacationName, object: self.theme)
    }
}
