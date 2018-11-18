//
//  HistoryViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/14.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class HistoryViewController: SuperViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countRecord = 0
    let mainVC = ViewController()
    //MARK: Setup CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var counts : [CountHistory] = []
    
    //MARK: Setup Haptic Feedback
    let hapticImpactLight = UIImpactFeedbackGenerator(style: .light)
    let hapticImpactMedium = UIImpactFeedbackGenerator(style: .medium)
    let hapticSelection = UISelectionFeedbackGenerator()
    let hapticNotification = UINotificationFeedbackGenerator()
    
    @IBOutlet weak var BackBtn: UIButton!
    @IBOutlet weak var ClearAllBtn: UIButton!
    
    @IBOutlet weak var HistoryTableView: UITableView!
    
    //MARK: - TableView DataSource Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForHistory", for: indexPath) as! HistoryTableViewCell
        let count = counts[indexPath.row]
        
        //Setup Label Display
        //Transform Date! to String named timeString
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.dateFormat = "yyyy.MM.dd "
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.dateFormat = " HH:mm"
        let recordDateStr = dateFormatterForDate.string(from: count.countDate!)
        let recordTimeStr = dateFormatterForTime.string(from: count.countDate!)
        let dateToday = dateFormatterForDate.string(from: Date())
        
        if  recordDateStr == dateToday {
            cell.TimeLb.text = NSLocalizedString("Today ", comment: "") + recordTimeStr
        } else {
            cell.TimeLb.text = recordDateStr + recordTimeStr
        }
        
        cell.CountNumLb.text = String(count.countNum)
        
        //Setup Selecteed Color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.InterfaceColor.darkGray.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        if Variables.countNum != Variables.fromRecord {
            mainVC.saveCountRecord()
        }
        Variables.countNum = Int(counts[indexPath.row].countNum)
        Variables.fromRecord = Variables.countNum
    }
    
    
    
    //MARK: - Swipe Actions on Cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Delete", comment: "")) { (action, indexPath) in
            self.context.delete(self.counts[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.counts.remove(at: indexPath.row)
            self.HistoryTableView.deleteRows(at: [indexPath], with: .bottom)
        }
        delete.backgroundColor = UIColor.InterfaceColor.red
        return [delete]
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        HistoryTableView.separatorColor = .clear
        loadData()
        
    }
    
    //MARK: - Functions
    func loadData() {
        getDataFromCoreData()
        sortRecords()
    }
    
    func sortRecords() {
        counts.sort() { $0.countDate! > $1.countDate! }
        HistoryTableView.reloadData()
    }
    
    func getDataFromCoreData() {
        do {
            counts = try context.fetch(CountHistory.fetchRequest())
        } catch {
            print("Fetching Failed:\(error)")
        }
    }
    
    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CountHistory")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        self.HistoryTableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ClearAllBtnTouchDown(_ sender: NaviBtn) {
        hapticImpactLight.impactOccurred()
    }
    @IBAction func ClearAllBtnPressed(_ sender: UIButton) {
        hapticImpactLight.impactOccurred()
        let addAlert = UIAlertController(title: NSLocalizedString("Delete All Record", comment: ""), message: NSLocalizedString("All history record will be Deleted. \n This is irreversible, are you sure to Delete?", comment: ""), preferredStyle: .alert)
        addAlert.addAction(UIKit.UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .destructive, handler: { (action) in
            self.deleteAllRecords()
            self.loadData()
            UIView.transition(with: self.HistoryTableView,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { self.HistoryTableView.reloadData() })
//            self.HistoryTableView.reloadData()
//            self.HistoryTableView.isHidden = true
            let time01: TimeInterval = 0.1
            let time02: TimeInterval = 0.2
            let time03: TimeInterval = 0.3
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time01) { self.hapticImpactLight.impactOccurred() }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time02) { self.hapticImpactLight.impactOccurred() }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time03) {
                self.dismiss(animated: true, completion: nil)
                self.hapticImpactMedium.impactOccurred()
            }
        }))
        addAlert.addAction(UIKit.UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
    }
    
}
