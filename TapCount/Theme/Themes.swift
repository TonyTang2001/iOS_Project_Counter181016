//
//  Themes.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/4.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
class OrangeBlackTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.orange
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.black
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
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkBlack
        }
    }
    
    var statusBarStyle: String {
        get {
            return "White"
        }
    }
    
}

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
            return UIColor.InterfaceColor.black
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkGray
        }
    }
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.lightGray
        }
    }
    
    var statusBarStyle: String {
        get {
            return "Dark"
        }
    }
    
}

class RedBlackTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.redXR
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.black
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
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkBlack
        }
    }
    
    var statusBarStyle: String {
        get {
            return "White"
        }
    }
    
}

class YellowWhiteTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.yellowXR
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.whiteXR
        }
    }
    
    var countDisplayColor: UIColor {
        get {
            return UIColor.InterfaceColor.black
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkGray
        }
    }
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.lightGray
        }
    }
    
    var statusBarStyle: String {
        get {
            return "Dark"
        }
    }
    
}

class CoralWhiteTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.coralXR
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.whiteXR
        }
    }
    
    var countDisplayColor: UIColor {
        get {
            return UIColor.InterfaceColor.black
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkGray
        }
    }
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.lightGray
        }
    }
    
    var statusBarStyle: String {
        get {
            return "Dark"
        }
    }
    
}

class BlueWhiteTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.blueXR
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.whiteXR
        }
    }
    
    var countDisplayColor: UIColor {
        get {
            return UIColor.InterfaceColor.black
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkGray
        }
    }
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.lightGray
        }
    }
    
    var statusBarStyle: String {
        get {
            return "Dark"
        }
    }
    
}

class XcodeTheme: ThemeProtocol {
    
    var mainColor: UIColor {
        get {
            return UIColor.InterfaceColor.oliGreenXcode
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return UIColor.InterfaceColor.cyanXcode
        }
    }
    
    var countDisplayColor: UIColor {
        get {
            return UIColor.InterfaceColor.darkPinkXcode
        }
    }
    
    var subLabelColor: UIColor {
        get {
            return UIColor.InterfaceColor.orangeXcode
        }
    }
    
    var cellSelectionColor: UIColor {
        get {
            return UIColor.InterfaceColor.purpleXcode
        }
    }
    
    var statusBarStyle: String {
        get {
            return "White"
        }
    }
    
}

//class MicroSft: ThemeProtocol {
//
//    var mainColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.lightGray
//        }
//    }
//
//    var backgroundColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.errorBlue_Micro
//        }
//    }
//
//    var countDisplayColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.lightGray
//        }
//    }
//
//    var subLabelColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.darkGray
//        }
//    }
//
//    var cellSelectionColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.blueLogo_Micro
//        }
//    }
//
//    var statusBarStyle: String {
//        get {
//            return "White"
//        }
//    }
//
//}

//class PkmTheme: ThemeProtocol {
//    
//    var mainColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.White_Pkm
//        }
//    }
//    
//    var backgroundColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.red_Pkm
//        }
//    }
//    
//    var countDisplayColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.darYellow_Pikachu
//        }
//    }
//    
//    var subLabelColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.darYellow_Pikachu
//        }
//    }
//    
//    var cellSelectionColor: UIColor {
//        get {
//            return UIColor.InterfaceColor.darkRed
//        }
//    }
//    
//    var statusBarStyle: String {
//        get {
//            return "White"
//        }
//    }
//    
//}
