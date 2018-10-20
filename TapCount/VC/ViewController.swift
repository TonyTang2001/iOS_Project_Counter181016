//
//  ViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/12.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import CoreData
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
    @IBOutlet weak var RefreshBtn: UIButton!
    
    @IBOutlet weak var CountBtn: UIButton!
    @IBOutlet weak var NumberLB: SpringLabel!
    @IBOutlet weak var AntiCountBtn: UIButton!
    
    //MARK: - Setup Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(Variables.countNum)
        refreshNumberLBDisplay()
        RefreshBtn.setTitleColor(UIColor.orange.withAlphaComponent(0.2),for: .highlighted)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshNumberLBDisplay()
    }
    
    //MARK: - Functions
    func refreshNumberLBDisplay() {
        print(Variables.countNum)
        NumberLB.text = String(Variables.countNum)
    }
    
    func receiveRecord(recordRow: Int) {
        print(recordRow)
    }
    
    func saveCountRecord() {
        if Variables.countNum != 0 {
            let countSave = CountHistory(context: context)
            countSave.countDate = Date()
            countSave.countNum = Int32(Variables.countNum)
            countSave.countType = "normal"
            countSave.multiMode = 1
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
        Variables.countNum = Variables.countNum + 1
        refreshNumberLBDisplay()
    }
    
    @IBAction func AntiCountBtnTapped(_ sender: UIButton) {
        hapticImpactLight.impactOccurred()
        if Variables.countNum > 0 {
            Variables.countNum = Variables.countNum - 1
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

