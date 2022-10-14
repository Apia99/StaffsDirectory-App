//
//  PeopleTableViewCell.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//
import Foundation
import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        imageAvatar.image = nil
        firstNameLabel.text = ""
        jobTitle.text = ""
    }
    func setData(staff: People) {
        firstNameLabel.text = staff.firstName + staff.lastName
        jobTitle.text = staff.jobTitle
        emailLabel.text = staff.email
        imageAvatar.layer.cornerRadius = imageAvatar.bounds.height / 2
        imageAvatar.clipsToBounds = true
    }
}
