//
//  LocationLookup.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll, Sanil Apte on 5/28/19.
//

import Foundation

struct LocationLookup {
    var origLat:Double
    var origLng:Double
    var destLat:Double
    var destLng:Double
    var timestamp:Date
    
    init(origLat:Double, origLng:Double, destLat:Double, destLng:Double, timestamp:Date) {
        self.origLat = origLat
        self.origLng = origLng
        self.destLat = destLat
        self.destLng = destLng
        self.timestamp = timestamp
    }
}
