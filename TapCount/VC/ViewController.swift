//
//  ViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/12.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {

    //MARK: Setup CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var counts : [CountHistory] = []
    
    //MARK: Setup Haptic Feedback
    let hapticImpactLight = UIImpactFeedbackGenerator(style: .light)
    let hapticSelection = UISelectionFeedbackGenerator()
    let hapticNotification = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var HistoryBtn: UIButton!
    @IBOutlet weak var MultiModeBtn: VKExpandableButton!
    @IBOutlet weak var RefreshBtn: UIButton!
    
    @IBOutlet weak var NumberLB: SpringLabel!
    @IBOutlet weak var AntiCountBtn: UIButton!
    @IBOutlet weak var CountBtn: UIButton!
    
    //MARK: - Setup Appearance
    //StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MultiMode Selection List
    func setupMultiModeBtn() {
        MultiModeBtn.direction = .Down
        MultiModeBtn.options = ["1x","3x","5x","10x"]
        let MutiIndex = [1,3,5,10]
        MultiModeBtn.currentValue = MultiModeBtn.options[0]
        MultiModeBtn.clipsToBounds = true
        MultiModeBtn.cornerRadius = MultiModeBtn.frame.size.height / 2
        MultiModeBtn.textColor = UIColor.black
        MultiModeBtn.expandedTextColor = UIColor.black
        MultiModeBtn.buttonBackgroundColor = UIColor.orange
        MultiModeBtn.expandedButtonBackgroundColor = UIColor.orange
        MultiModeBtn.selectionColor = UIColor.white.withAlphaComponent(0.3)
        MultiModeBtn.optionSelectionBlock = {
            index in
            print(MutiIndex[index])
            self.setMultiMode(Multi: MutiIndex[index])
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setMultiMode(Multi: 1)
        setupMultiModeBtn()
        refreshNumberLBDisplay()
        RefreshBtn.setTitleColor(UIColor.orange.withAlphaComponent(0.2),for: .highlighted)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshNumberLBDisplay()
    }
    
    //MARK: - Functions
    func setMultiMode(Multi: Int) {
        Variables.multiMode = Multi
        let MultiStr = String(Multi)
        AntiCountBtn.setTitle("-" + MultiStr, for: .normal)
        CountBtn.setTitle("+" + MultiStr, for: .normal)
    }
    
    func refreshNumberLBDisplay() {
        print(Variables.countNum)
        NumberLB.text = String(Variables.countNum)
    }
    
    func saveCountRecord() {
        if Variables.countNum != 0 {
            let countSave = CountHistory(context: context)
            countSave.countDate = Date()
            countSave.countNum = Int32(Variables.countNum)
            countSave.countType = "normal"
            countSave.multiMode = Int32(Variables.multiMode)
            countSave.note = ""
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
            //Do Nothing
        }
    }
    
    //MARK: - IBActions
    @IBAction func CountBtnTapped(_ sender: UIButton) {
        hapticImpactLight.impactOccurred()
        print(Variables.countNum)
        Variables.countNum = Variables.countNum + Variables.multiMode
        refreshNumberLBDisplay()
    }
    
    @IBAction func AntiCountBtnTapped(_ sender: UIButton) {
        hapticImpactLight.impactOccurred()
        if Variables.countNum >= Variables.multiMode {
            Variables.countNum = Variables.countNum - Variables.multiMode
        } else {
            hapticNotification.notificationOccurred(.error)
            NumberLB.animation = "shake"
            NumberLB.animate()
        }
        
        refreshNumberLBDisplay()
    }
    
    
    @IBAction func RefreshBtnPressed(_ sender: UIButton) {
        hapticImpactLight.impactOccurred()
        saveCountRecord()
        Variables.countNum = 0
        NumberLB.text = "0"
//        print(applicationDirectoryPath())
    }
    
//    func applicationDirectoryPath() -> String {
//        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
//    }
    
}

