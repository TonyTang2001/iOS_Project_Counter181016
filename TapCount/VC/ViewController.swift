//
//  ViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/12.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import Spring
//import AudioToolbox
import AVFoundation
//import MediaPlayer

class ViewController: SuperViewController {
    
    //MARK: - Preset
    var player = AVAudioPlayer()
    var soundEnabled: Bool = true
//    private var audioLevel: Float = 0.0
    let userDefaults = UserDefaults.standard
    let soundEffect = "soundEffect"
    let keepScreenOn = "keepScreenOn"
//    let useVolBtn = "useVolBtn"
    let shakeToClear = "shakeToClear"
    let themeName = "themeName"
    
    //MARK: Setup CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Setup Haptic Feedback
    let hapticImpactLight = UIImpactFeedbackGenerator(style: .light)
    let hapticImpactMedium = UIImpactFeedbackGenerator(style: .medium)
    let hapticSelection = UISelectionFeedbackGenerator()
    let hapticNotification = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var HistoryBtn: NaviBtn!
    @IBOutlet weak var MultiModeBtn: MultiModeBtn!
    @IBOutlet weak var ClearBtn: NaviBtn!
    @IBOutlet weak var NumberLB: SpringLabel!
    @IBOutlet weak var AntiCountBtn: AntiCountBtn!
    @IBOutlet weak var CountBtn: CountBtn!
    
    //MultiMode Selection List
    func setupMultiModeBtn() {
        let MutiIndex = [1,3,5,10,100]
        MultiModeBtn.options = ["1x","3x","5x","10x","100x"]
        MultiModeBtn.direction = .Down
        MultiModeBtn.currentValue = MultiModeBtn.options[0]
        MultiModeBtn.clipsToBounds = true
        MultiModeBtn.cornerRadius = MultiModeBtn.frame.size.height / 2
        
        MultiModeBtn.optionSelectionBlock = {
            index in
            print(MutiIndex[index])
            self.setMultiMode(Multi: MutiIndex[index])
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        
        self.CountBtn = CountBtn!
        firstLaunch()
        setMultiMode(Multi: 1)
        setupMultiModeBtn()
        refreshNumberLBDisplay()
//        listenVolumeButton()
//        ClearBtn.setTitleColor(UIColor.InterfaceColor.orange.withAlphaComponent(0.2),for: .highlighted)
        setupUserSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshNumberLBDisplay()
        setupUserSettings()
    }
    
    //MARK: - Functions
    func firstLaunch() {
        let launchedBefore = userDefaults.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            userDefaults.set(true, forKey: "launchedBefore")
            userDefaults.set(true, forKey: soundEffect)
            userDefaults.set(true, forKey: keepScreenOn)
            userDefaults.set(true, forKey: shakeToClear)
            userDefaults.set(NaviWhiteTheme(), forKey: themeName)
        }
    }
//    func listenVolumeButton(){
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setActive(true, options: [])
//            audioSession.addObserver(self, forKeyPath: "outputVolume",
//                                     options: NSKeyValueObservingOptions.new, context: nil)
//            audioLevel = audioSession.outputVolume
//        } catch {
//            print("Error")
//        }
//    }
//
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "outputVolume"{
//            let audioSession = AVAudioSession.sharedInstance()
//            if audioSession.outputVolume > audioLevel {
////                CountBtnTapped()
//                audioLevel = audioSession.outputVolume
//            }
//            if audioSession.outputVolume < audioLevel {
//                print("GoodBye")
//                audioLevel = audioSession.outputVolume
//            }
//            if audioSession.outputVolume > 0.999 {
//                (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.9375, animated: false)
//                audioLevel = 0.9375
//            }
//
//            if audioSession.outputVolume < 0.001 {
//                (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.0625, animated: false)
//                audioLevel = 0.0625
//            }
//        }
//    }
    
    func setupUserSettings() {
        if userDefaults.bool(forKey: soundEffect) {
            soundEnabled = true
        } else if userDefaults.bool(forKey: soundEffect) == false {
            soundEnabled = false
        }
        
        if userDefaults.bool(forKey: keepScreenOn) {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
//        if userDefeults.bool(forKey: useVolBtn) { }
        
        //Already Sat in motionEnded
//        if userDefeults.bool(forKey: shakeToClear) { }
    }
    
    //For Shake Motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && userDefaults.bool(forKey: shakeToClear) {
            refreshCount()
        }
    }
    
    func setMultiMode(Multi: Int) {
        Variables.multiMode = Multi
        let MultiStr = String(Multi)
        AntiCountBtn.setTitle("- " + MultiStr, for: .normal)
        CountBtn.setTitle("+ " + MultiStr, for: .normal)
    }
    
    func refreshNumberLBDisplay() {
        NumberLB.text = String(Variables.countNum)
    }
    
    func saveCountRecord() {
        if Variables.countNum != 0 && Variables.countNum != Variables.fromRecord {
            let countSave = CountHistory(context: context)
            countSave.countDate = Date()
            countSave.countNum = Int32(Variables.countNum)
            countSave.countType = "normal"
            countSave.note = ""
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
            //Do Nothing
        }
    }
    
    func countUp() {
        Variables.countNum = Variables.countNum + Variables.multiMode
        refreshNumberLBDisplay()
        
        //Animation for NumberLb
        //        UIView.animate(withDuration: 0.1, animations: {
        //            self.NumberLB.transform = self.NumberLB.transform.scaledBy(x: 1.01, y: 1.05)
        //        }) { (success) in
        //            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
        //                self.NumberLB.transform = CGAffineTransform.identity
        //            }, completion: nil)
        //        }
    }
    
    func countDown() {
        if Variables.countNum == 0 {
            antiCountError()
        }
        if Variables.countNum >= Variables.multiMode {
            Variables.countNum = Variables.countNum - Variables.multiMode
        } else {
            Variables.countNum = 0
            antiCountError()
        }
        
        refreshNumberLBDisplay()
    }
    
    func refreshCount() {
        hapticImpactLight.impactOccurred()
        saveCountRecord()
        Variables.countNum = 0
        NumberLB.text = "0"
    }
    
    func antiCountError() {
        hapticNotification.notificationOccurred(.error)
        NumberLB.animation = "shake"
        NumberLB.animate()
    }
    
    //MARK: - IBActions
    @IBAction func CountBtnTouchDown(_ sender: CountBtn) {
        //SoundEffect
        if userDefaults.bool(forKey: soundEffect) {
            let path = Bundle.main.path(forResource: "CountBtn_Default", ofType: "wav")!
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch { print ("SoundError:\(error)") }
        }
        hapticImpactMedium.impactOccurred()
        countUp()
    }
    @IBAction func CountBtnTapped(_ sender: CountBtn) {
//        countUp()
    }
    
    @IBAction func AntiCountBtnTouchDown(_ sender: AntiCountBtn) {
        //SoundEffect
        if userDefaults.bool(forKey: soundEffect) {
            let path = Bundle.main.path(forResource: "AntiCountBtn_Default", ofType: "wav")!
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch { print ("SoundError:\(error)") }
        }
        hapticImpactLight.impactOccurred()
        countDown()
    }
    @IBAction func AntiCountBtnTapped(_ sender: AntiCountBtn) {
//        countDown()
    }
    
    @IBAction func ClearBtnTouchDown(_ sender: NaviBtn) {
        hapticImpactLight.impactOccurred()
    }
    @IBAction func ClearBtnPressed(_ sender: NaviBtn) {
        refreshCount()
//        print(applicationDirectoryPath())
    }
    @IBAction func HistoryBtnPressed(_ sender: NaviBtn) {
//        resignFirstResponder()
    }
    //MARK: - Locate CoreData data files for Debugging
//    func applicationDirectoryPath() -> String {
//        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String
//    }
}

