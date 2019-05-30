//
//  GeoCalcButton.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll & Sanil Apte on 5/21/19.
//

import UIKit

class GeoCalcButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }

}
