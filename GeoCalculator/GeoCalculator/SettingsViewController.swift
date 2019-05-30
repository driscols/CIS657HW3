//
//  SettingsViewController.swift
//  GeoCalculator
//
//  Created by Sanil A. Apte & Sean Driscoll on 5/16/19.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
    
}

class SettingsViewController: UIViewController {
   

  
    
    @IBOutlet weak var bearing: UILabel!
    @IBOutlet weak var dist: UILabel!
    @IBOutlet weak var settingsPicker: UIPickerView!
    var pickerData: [String] = [String]()
    var delegate: SettingsViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsPicker.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapDist))
        dist.addGestureRecognizer(tap)
        let tapTwo = UITapGestureRecognizer(target: self, action: #selector(self.tapBearing))
        bearing.addGestureRecognizer(tapTwo)
        let tapAnywhere = UITapGestureRecognizer(target: self, action: #selector(self.tapAny))
        view.addGestureRecognizer(tapAnywhere)
    }
    @IBAction func btnCancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapDist(sender:UITapGestureRecognizer) {
        //populate picker
        settingsPicker.isHidden = false
        self.pickerData = ["Kilometers", "Miles"]
        self.settingsPicker.delegate = self
        self.settingsPicker.dataSource = self
    }
    @objc func tapBearing(sender:UITapGestureRecognizer) {
        //populate picker
        settingsPicker.isHidden = false
        self.pickerData = ["Degrees", "Mils"]
        self.settingsPicker.delegate = self
        self.settingsPicker.dataSource = self
       
    }
    
    @objc func tapAny(sender:UITapGestureRecognizer){
        settingsPicker.isHidden = true
    }
    @IBAction func saveOps(_ sender: Any) {
        if let d = self.delegate{
            d.settingsChanged(distanceUnits: dist.text!, bearingUnits: bearing.text!)
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(self.pickerData[row] == "Degrees" || self.pickerData[row] == "Mils"){
            self.bearing.text = self.pickerData[row]
        }
        else{
            self.dist.text = self.pickerData[row]
        }
        
    }
}

