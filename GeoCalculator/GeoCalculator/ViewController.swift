//
//  ViewController.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll on 5/14/19.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    
    @IBOutlet weak var LatP1: DecimalMinusTextField!
    @IBOutlet weak var LatP2: DecimalMinusTextField!
    @IBOutlet weak var LongP1: DecimalMinusTextField!
    @IBOutlet weak var LongP2: DecimalMinusTextField!
    
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var BearingLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickCalculate(_ sender: Any) {
        let fLatP1 :Double? = Double(LatP1.text!)
        let fLatP2 :Double? = Double(LatP2.text!)
        let fLongP1 :Double? = Double(LongP1.text!)
        let fLongP2 : Double? = Double(LongP2.text!)
        
        let p1 = CLLocation(latitude: fLatP1!, longitude: fLongP1!)
        let p2 = CLLocation(latitude: fLatP2!, longitude: fLongP2!)
        
        let distance = round(p1.distance(from: p2) * 100) / 100
        
        let bearing = round(p1.bearingToPoint(point: p2) * 100) / 100
        
        DistanceLabel.text = "Distance: \(distance) km"
        BearingLabel.text = "Bearing: \(bearing) degrees"
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        LatP1.text = ""
        LatP2.text = ""
        LongP1.text = ""
        LongP2.text = ""
        DistanceLabel.text = "Distance:"
        BearingLabel.text = "Bearing:"
    }
}

