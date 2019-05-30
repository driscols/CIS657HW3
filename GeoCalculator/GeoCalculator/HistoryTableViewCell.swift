//
//  HistoryTableViewCell.swift
//  GeoCalculator
//
//  Created by Sean J. Driscoll & Sanil Apte on 5/28/19.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var destPoint: UILabel!
    @IBOutlet weak var origPoint: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
