//
//  SettingsViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/20.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var BackBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion:  nil)
    }
    @IBAction func ReviewBtnPressed(_ sender: UIButton) {
        SKStoreReviewController.requestReview()
    }
    

}
