//
//  SettingsTableViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/27.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import StoreKit

class SettingsTableViewController: UITableViewController {

    //MARK: - Preset
    let userDefeults = UserDefaults.standard
    let soundEffect = "soundEffect"
    let keepScreenOn = "keepScreenOn"
//    let useVolBtn = "useVolBtn"
    let shakeToClear = "shakeToClear"
    
    //MARK: - Outlets
    @IBOutlet weak var soundEffectSwt: UISwitch!
    @IBOutlet weak var keepScreenOnSwt: UISwitch!
    @IBOutlet weak var shakeToClearSwt: UISwitch!
    
    @IBOutlet weak var colorsAndStylesCell: UITableViewCell!
    @IBOutlet weak var soundEffectCell: UITableViewCell!
    @IBOutlet weak var keepScreenOnCell: UITableViewCell!
    @IBOutlet weak var shakeToClearCell: UITableViewCell!
    @IBOutlet weak var contactDevCell: UITableViewCell!
    @IBOutlet weak var rateCell: UITableViewCell!
    
    @IBOutlet weak var nameAndVersion: UILabel!
    
    //MARK: - Selection Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            //Select Colors & Styles
        } else if indexPath.section == 2 && indexPath.row == 0 {
            //Contact
            let contactAlert = UIAlertController(title: "Contact Developer", message: "You may contact TonyTang by the following ways.", preferredStyle: .alert)
            
            let weChat = UIAlertAction(title: "WeChat", style: .default) { (action) in
                UIPasteboard.general.string = "Tony-398102832"
                let wechatAlert = UIAlertController(title: "WeChat ID Copied", message: "Paste in WeChat to search.", preferredStyle: .alert)
                let go = UIAlertAction(title: "Go to WeChat", style: .default, handler: { (action) in
                    guard let url = URL(string: "wechat://") else {return}
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                })
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                wechatAlert.addAction(go)
                wechatAlert.addAction(cancel)
                self.present(wechatAlert, animated: true, completion: nil)
            }
            
            let weibo = UIAlertAction(title: "Weibo", style: .default) { (action) in
                guard let url = URL(string: "sinaweibo://userinfo?uid=2608542673") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let facebook = UIAlertAction(title: "Facebook", style: .default) { (action) in
                guard let url = URL(string: "fb://profiles/100012964713869") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let email = UIAlertAction(title: "Email", style: .default) { (action) in
                guard let url = URL(string: "mailto://tonytangdev17@hotmail.com") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let gitHub = UIAlertAction(title: "GitHub", style: .default) { (action) in
                guard let url = URL(string: "https://github.com/TonyTang2001") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            contactAlert.addAction(weChat)
            contactAlert.addAction(weibo)
            contactAlert.addAction(facebook)
            contactAlert.addAction(email)
            contactAlert.addAction(gitHub)
            contactAlert.addAction(cancel)
            present(contactAlert, animated: true, completion: nil)
        } else if indexPath.section == 2 && indexPath.row == 1 {
            //Rate
            SKStoreReviewController.requestReview()
//            let addAlert = UIAlertController(title: NSLocalizedString("Thank you!", comment: ""), message: NSLocalizedString("Thank you for your patient Review.", comment: ""), preferredStyle: .alert)
//            addAlert.addAction(UIKit.UIAlertAction(title: NSLocalizedString("OK, I know.👌", comment: ""), style: .cancel, handler: nil))
//            self.present(addAlert, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        setupSwts()
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        nameAndVersion.text = NSLocalizedString("Count Now", comment: "") + " ∙ v" + appVersion
    }
    
    //MARK: - Functions
    func setupCells() {
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.InterfaceColor.darkBlack
        colorsAndStylesCell.selectedBackgroundView = selectionColor
        contactDevCell.selectedBackgroundView = selectionColor
        rateCell.selectedBackgroundView = selectionColor
        
        soundEffectCell.selectionStyle = .none
        keepScreenOnCell.selectionStyle = .none
//        useVolBtnCell.selectionStyle = .none
        shakeToClearCell.selectionStyle = .none
    }
    
    func setupSwts() {
        soundEffectSwt.isOn = userDefeults.bool(forKey: soundEffect)
        keepScreenOnSwt.isOn = userDefeults.bool(forKey: keepScreenOn)
//        useVolBtnSwt.isOn = userDefeults.bool(forKey: useVolBtn)
        shakeToClearSwt.isOn = userDefeults.bool(forKey: shakeToClear)
    }
    
    @IBAction func soundEffectSwtPressed(_ sender: UISwitch) {
        userDefeults.set(soundEffectSwt.isOn, forKey: soundEffect)
//        print(userDefeults.bool(forKey: soundEffect))
    }
    @IBAction func keepScreenOnSwtPressed(_ sender: UISwitch) {
        userDefeults.set(keepScreenOnSwt.isOn, forKey: keepScreenOn)
//        print(userDefeults.bool(forKey: keepScreenOn))
    }
    @IBAction func shakeToClearSwtPressed(_ sender: UISwitch) {
        userDefeults.set(shakeToClearSwt.isOn, forKey: shakeToClear)
//        print(userDefeults.bool(forKey: shakeToClear))
    }
    
    
}



