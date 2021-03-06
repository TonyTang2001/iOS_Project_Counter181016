//
//  SettingsViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/20.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class SettingsViewController: SuperViewController {

    @IBOutlet weak var BackBtn: NaviBtn!
    @IBOutlet weak var ContainerVforSettingsStatic: UIView!
    @IBOutlet weak var CopyrightTonyTang: DevNameLb!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stunning Fade Effects at ends of CollectionView, LOL
        let gradient = CAGradientLayer()
        gradient.frame = ContainerVforSettingsStatic.bounds
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor(white: 1, alpha: 1).cgColor,
            UIColor.clear.cgColor
        ]
        //Asymmetry for implication of horizontal scrolling.
        gradient.locations = [0, 0.05, 0.88, 0.96]
        ContainerVforSettingsStatic.layer.mask = gradient
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        CopyrightTonyTang.text = String(year) + " TonyTangⓇ"
    }
    
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion:  nil)
    }
    
}
