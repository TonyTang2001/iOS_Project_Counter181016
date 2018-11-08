//
//  ThemeProtocol.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/4.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var countDisplayColor: UIColor { get }
    var subLabelColor: UIColor { get }
}

enum ThemeType {
    case orangeBlackTheme
    case naviWhiteTheme
    case redBlackTheme
    
    var theme: ThemeProtocol {
        get {
            switch self {
            case .orangeBlackTheme:
                return OrangeBlackTheme()
            case .naviWhiteTheme:
                return NaviWhiteTheme()
            case .redBlackTheme:
                return RedBlackTheme()
            }
        }
    }
}
