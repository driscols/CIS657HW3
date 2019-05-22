//
//  ViewController.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll on 5/14/19.
//

import UIKit
import CoreLocation

class ViewController: GeoCalcViewController, SettingsViewControllerDelegate {

    
    
    @IBOutlet weak var LatP1: DecimalMinusTextField!
    @IBOutlet weak var LatP2: DecimalMinusTextField!
    @IBOutlet weak var LongP1: DecimalMinusTextField!
    @IBOutlet weak var LongP2: DecimalMinusTextField!
    
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var BearingLabel: UILabel!
    var distUnits:String = "Kilometers"
    var bearUnits:String = "Degrees"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickCalculate(_ sender: Any) {
        settingsChanged(distanceUnits: distUnits, bearingUnits: bearUnits)
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        LatP1.text = ""
        LatP2.text = ""
        LongP1.text = ""
        LongP2.text = ""
        DistanceLabel.text = "Distance:"
        BearingLabel.text = "Bearing:"
    }
    func settingsChanged(distanceUnits: String, bearingUnits: String){
        distUnits = distanceUnits
        bearUnits = bearingUnits
        let fLatP1 :Double? = Double(LatP1.text!)
        let fLatP2 :Double? = Double(LatP2.text!)
        let fLongP1 :Double? = Double(LongP1.text!)
        let fLongP2 : Double? = Double(LongP2.text!)
        
        let p1 = CLLocation(latitude: fLatP1!, longitude: fLongP1!)
        let p2 = CLLocation(latitude: fLatP2!, longitude: fLongP2!)
        
        let distance = round((p1.distance(from: p2)/1000) * 100) / 100
        
        let bearing = round(p1.bearingToPoint(point: p2) * 100) / 100
        
        if(distanceUnits != "Kilometers"){
            let mi = round(distance / 62.1371) / 100
            DistanceLabel.text = "Distance: \(mi) miles"
        
        }
        else{
            DistanceLabel.text = "Distance: \(distance) km"
        }
        
        if(bearingUnits != "Degrees"){
            let mils = round(bearing * 1777.77777778) / 100
             BearingLabel.text = "Bearing: \(mils) mils"
            
        }
        else{
             BearingLabel.text = "Bearing: \(bearing) degrees"
        }
        
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if let nc = segue.destination as? UINavigationController{
            if let dest = nc.children[0] as? SettingsViewController{
                dest.delegate = self
            }
        }
    }
}

