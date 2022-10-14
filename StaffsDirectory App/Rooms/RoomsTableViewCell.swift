//
//  RoomsTableViewCell.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var occupiedLabel: UILabel!
    @IBOutlet weak var maxOccupancyLabel: UILabel!
    
    override func prepareForReuse() {
        idLabel.text = ""
        occupiedLabel.text = ""
        maxOccupancyLabel.text = ""
    }
    
    func setData(room: Room) {
        idLabel.text = room.id
        occupiedLabel.text = room.occupiedMessage
        maxOccupancyLabel.text = "\(room.maxOccupancy)"
        occupiedLabel.textColor = room.color
    }
}
