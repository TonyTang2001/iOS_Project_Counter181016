//
//  SuperViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/4.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController, ThemeManagerProtocol {
    
    var statusBarStyle: String = "White"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.changeTheme()
    }
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)), name: ThemeNotifacationName, object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        
        self.view.backgroundColor = theme.backgroundColor
        self.statusBarStyle = theme.statusBarStyle
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if statusBarStyle == "White" {
            return .lightContent
        } else {
            return .default
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
