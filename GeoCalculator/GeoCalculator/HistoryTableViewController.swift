//
//  HistoryTableViewController.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll on 5/28/19.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    
    var entries : [LocationLookup] = []
    var historyDelegate:HistoryTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortIntoSections(entries: self.entries)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let data = self.tableViewData {
            return data.count
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sectionInfo = self.tableViewData?[section] {
            return sectionInfo.entries.count
        } else {
            return 0
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FancyCell", for: indexPath) as! HistoryTableViewCell
        
        //let ll = entries[indexPath.row]
        if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
            cell.origPoint.text = "(\(ll.origLat.roundTo(places:4)),\(ll.origLng.roundTo(places:4)))"
            cell.destPoint.text = "(\(ll.destLat.roundTo(places: 4)),\(ll.destLng.roundTo(places: 4)))"
            cell.timestamp.text = ll.timestamp.description
        }
        return cell
    }

 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // use the historyDelegate to report back entry selected to the calculator scene
        if let del = self.historyDelegate {
            let ll = entries[indexPath.row]
            del.selectEntry(entry: ll)
        }
        
        // this pops to the calculator
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    var tableViewData: [(sectionHeader: String, entries: [LocationLookup])]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func sortIntoSections(entries: [LocationLookup]) {
        
        var tmpEntries : Dictionary<String,[LocationLookup]> = [:]
        var tmpData: [(sectionHeader: String, entries: [LocationLookup])] = []
        
        // partition into sections
        for entry in entries {
            let shortDate = entry.timestamp.short
            if var bucket = tmpEntries[shortDate] {
                bucket.append(entry)
                tmpEntries[shortDate] = bucket
            } else {
                tmpEntries[shortDate] = [entry]
            }
        }
        
        // breakout into our preferred array format
        let keys = tmpEntries.keys
        for key in keys {
            if let val = tmpEntries[key] {
                tmpData.append((sectionHeader: key, entries: val))
            }
        }
        
        // sort by increasing date.
        tmpData.sort { (v1, v2) -> Bool in
            if v1.sectionHeader < v2.sectionHeader {
                return true
            } else {
                return false
            }
        }
        
        self.tableViewData = tmpData
    }



    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: LocationLookup)
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension Date {
    struct Formatter {
        static let short: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    
    var short: String {
        return Formatter.short.string(from: self)
    }
}