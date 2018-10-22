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
    @IBAction func ReviewBtnPressed(_ sender: UIButton) {
        SKStoreReviewController.requestReview()
        
        let addAlert = UIAlertController(title: "Thank you!", message: "Thank you so much for your patient Review", preferredStyle: .alert)
        addAlert.addAction(UIKit.UIAlertAction(title: "OK, I know.", style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
    }
    

}
