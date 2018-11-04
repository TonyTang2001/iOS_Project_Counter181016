//
//  ColorSelectionViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/31.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class ColorSelectionViewController: SuperViewController, SBCardPopupContent
{
    //Setup Popup View
    var popupViewController: SBCardPopupViewController?
    var allowsTapToDismissPopupCard: Bool = true
    var allowsSwipeToDismissPopupCard: Bool = false
    static func create() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ColorSelectionViewController") as! ColorSelectionViewController
        return storyboard
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
