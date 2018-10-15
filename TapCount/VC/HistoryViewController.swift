//
//  HistoryViewController.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/14.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countRecord = 0
    //Setup Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var counts : [CountHistory] = []
    
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd  HH:mm"
            let countDateString = dateFormatter.string(from: count.countDate!)
        cell.TimeLb.text = countDateString
        cell.CountNumLb.text = String(count.countNum)
        
        //Setup Selecteed Color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    //MARK: - Swipe Actions on Cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.context.delete(self.counts[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.counts.remove(at: indexPath.row)
            self.HistoryTableView.deleteRows(at: [indexPath], with: .bottom)
        }
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        countRecord = Int(counts[indexPath.row].countNum)
//        
//        performSegue(withIdentifier: "HistoryToCountVCSegue", sender: countRecord)
//        
//    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        HistoryTableView.separatorColor = .clear
        loadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        //        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "HistoryToCountVCSegue" {
//            let destVC = segue.destination as! ViewController
//            destVC.recordNumber = sender as! Int
//        }
//    }
    
    
    //MARK: - IBActions
    @IBAction func BackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ClearAllBtnPressed(_ sender: UIButton) {
        let addAlert = UIAlertController(title: "Delete All Record", message: "All history record will be Deleted. \n This is irreversible, are you sure to Delete?", preferredStyle: .alert)
        addAlert.addAction(UIKit.UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.deleteAllRecords()
            self.loadData()
            UIView.transition(with: self.HistoryTableView,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { self.HistoryTableView.reloadData() })
//            self.HistoryTableView.reloadData()
//            self.HistoryTableView.isHidden = true
            let time: TimeInterval = 0.3
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) { self.dismiss(animated: true, completion: nil) }
        }))
        addAlert.addAction(UIKit.UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addAlert, animated: true, completion: nil)
    }
    

}
