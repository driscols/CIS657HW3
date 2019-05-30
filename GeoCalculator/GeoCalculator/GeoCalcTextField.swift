//
//  GeoCalcTextField.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll & Sanil Apte on 5/21/19.
//

import UIKit

class GeoCalcTextField: DecimalMinusTextField {

    override func awakeFromNib() {
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        
        
        guard let ph = self.placeholder else{
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: FOREGROUND_COLOR])
    }

}
