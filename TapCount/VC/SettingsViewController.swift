//
//  SettingsViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/20.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class SettingsViewController: SuperViewController {

    @IBOutlet weak var BackBtn: UIButton!
    
    //MARK: - Setup Appearance
    //StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion:  nil)
    }
    
}
