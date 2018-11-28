//
//  SettingsTableViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/27.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import StoreKit

enum CellTitleType: Int {
    case OrangeBlack, NaviWhite, RedBlack
    var themeType : ThemeType {
        get {
            switch self {
            case .OrangeBlack:
                return .orangeBlackTheme
            case .NaviWhite:
                return .naviWhiteTheme
            case .RedBlack:
                return .redBlackTheme
            }
        }
    }
    
}

class SettingsTableViewController: UITableViewController, ThemeManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Preset
    let userDefeults = UserDefaults.standard
    let soundEffect = "soundEffect"
    let keepScreenOn = "keepScreenOn"
    //    let useVolBtn = "useVolBtn"
    let shakeToClear = "shakeToClear"
    let themeName = "themeName"
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)), name: ThemeNotifacationName, object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else {
            return
        }
        self.view.backgroundColor = theme.backgroundColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    let array:[String] = ["orangeBlack","naviWhite","redBlack"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorSelectionCollectionViewCell
        
        cell.colorPadImgV.image = UIImage(named: array[indexPath.row] + ".png")
        
        return cell
    }
    
    func switcherTheme(type: CellTitleType) {
        ThemeManager.switcherTheme(type: type.themeType)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Switch Themes
        guard let cellType: CellTitleType = CellTitleType(rawValue: indexPath.row) else { return }
        self.switcherTheme(type: cellType)
        
        print(cellType.themeType.theme)
//        Variables.theme = cellType.themeType.theme
        let selectedTheme = cellType.themeType.theme
        if selectedTheme == OrangeBlackTheme() {
            userDefeults.set("OrangeBlackTheme()", forKey: themeName)
        } else if selectedTheme == NaviWhiteTheme() {
            userDefeults.set("NaviWhiteTheme()", forKey: themeName)
        } else if selectedTheme == RedBlackTheme() {
            userDefeults.set("RedBlackTheme()", forKey: themeName)
        }
        
        let addAlert = UIAlertController(title: NSLocalizedString("Theme Changed", comment: ""), message: NSLocalizedString("Enjoy your new Theme.", comment: ""), preferredStyle: .alert)
        addAlert.addAction(UIKit.UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
    }
    
    //MARK: - Outlets
    @IBOutlet weak var soundEffectSwt: SuperSettingsSwt!
    @IBOutlet weak var keepScreenOnSwt: SuperSettingsSwt!
    @IBOutlet weak var shakeToClearSwt: SuperSettingsSwt!
    
    @IBOutlet weak var colorsAndStylesCell: SettingsSelectableCell!
    @IBOutlet weak var colorsSelectionCell: SettingsSelectableCell!
    @IBOutlet weak var soundEffectCell: SuperSettingsCell!
    @IBOutlet weak var keepScreenOnCell: SuperSettingsCell!
    @IBOutlet weak var shakeToClearCell: SuperSettingsCell!
    @IBOutlet weak var contactDevCell: SettingsSelectableCell!
    @IBOutlet weak var rateCell: SettingsSelectableCell!
    @IBOutlet weak var privacyPolicyCell: SettingsSelectableCell!
    @IBOutlet weak var acknowledgementCell: SettingsSelectableCell!
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var nameAndVersion: UILabel!
    
    //MARK: - Selection Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            //Select Colors & Styles
//            let popup = ColorSelectionViewController.create()
//            let sbPopup = SBCardPopupViewController(contentViewController: popup)
//            sbPopup.show(onViewController: self)
            
        } else if indexPath.section == 2 && indexPath.row == 0 {
            //Contact
            let contactAlert = UIAlertController(title: NSLocalizedString("Contact Developer", comment: ""), message: NSLocalizedString("You may contact TonyTang by the following ways.", comment: ""), preferredStyle: .alert)
            
            let weChat = UIAlertAction(title: NSLocalizedString("WeChat", comment: ""), style: .default) { (action) in
                UIPasteboard.general.string = "Tony-398102832"
                let wechatAlert = UIAlertController(title: NSLocalizedString("WeChat ID Copied", comment: ""), message: NSLocalizedString("Paste in WeChat to search.", comment: ""), preferredStyle: .alert)
                let go = UIAlertAction(title: NSLocalizedString("Go to WeChat", comment: ""), style: .default, handler: { (action) in
                    guard let url = URL(string: "wechat://") else {return}
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                })
                let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
                wechatAlert.addAction(go)
                wechatAlert.addAction(cancel)
                self.present(wechatAlert, animated: true, completion: nil)
            }
            
            let weibo = UIAlertAction(title: NSLocalizedString("Weibo", comment: ""), style: .default) { (action) in
                guard let url = URL(string: "sinaweibo://userinfo?uid=2608542673") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let facebook = UIAlertAction(title: NSLocalizedString("Facebook", comment: ""), style: .default) { (action) in
                guard let url = URL(string: "fb://profiles/100012964713869") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let email = UIAlertAction(title: NSLocalizedString("Email", comment: ""), style: .default) { (action) in
                guard let url = URL(string: "mailto://tonytangdev17@hotmail.com") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let gitHub = UIAlertAction(title: NSLocalizedString("GitHub", comment: ""), style: .default) { (action) in
                guard let url = URL(string: "https://github.com/TonyTang2001") else {return}
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
            contactAlert.addAction(weChat)
            contactAlert.addAction(weibo)
            contactAlert.addAction(facebook)
            contactAlert.addAction(email)
            contactAlert.addAction(gitHub)
            contactAlert.addAction(cancel)
            
            present(contactAlert, animated: true, completion: nil)
        } else if indexPath.section == 2 && indexPath.row == 1 {
            //Rate
            let askForRate = UIAlertController(title: NSLocalizedString("Like 'Count Now'?", comment: ""), message: NSLocalizedString("You may rate 'Count Now' here. \n We are eager for your encouragement and feedbacks!", comment: ""), preferredStyle: .alert)
            askForRate.addAction(UIKit.UIAlertAction(title: NSLocalizedString("Not now", comment: ""), style: .cancel, handler: nil))
            askForRate.addAction(UIKit.UIAlertAction(title: NSLocalizedString("Rate", comment: ""), style: .default) { (action) in  SKStoreReviewController.requestReview()  })
            self.present(askForRate, animated: true, completion: nil)
            
        } else if indexPath.section == 2 && indexPath.row == 2 {
            guard let url = URL(string: NSLocalizedString("https://github.com/TonyTang2001/iOS_Project_Counter181016/blob/master/Privacy%20Policy.md", comment: "")) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else if indexPath.section == 2 && indexPath.row == 3 {
            guard let url = URL(string: "https://github.com/TonyTang2001/iOS_Project_Counter181016/blob/master/Acknowledgement.md") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        self.tableView.reloadData()
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeTheme()
        setupSwts()
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        nameAndVersion.text = NSLocalizedString("Count Now", comment: "") + " ∙ v " + appVersion
    }
    
    //MARK: - Functions
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
