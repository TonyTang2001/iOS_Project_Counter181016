//
//  NaviWhiteTheme.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/4.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
class NaviWhiteTheme: ThemeProtocol {
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.naviBlue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.white
        }
    }
    
    var countDisplayColor: UIColor {
        get {
            return UIColor.InterfaceColor.white
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.lightGray
        }
    }
    
}
