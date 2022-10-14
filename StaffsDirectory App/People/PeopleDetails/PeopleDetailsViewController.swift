//
//  PeopleDetailsViewController.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import UIKit

class PeopleDetailsViewController: UIViewController {
    
    @IBOutlet weak var staffPotrait: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    var viewModel:PeopleDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        firstNameLabel.text = viewModel.people.firstName
        lastNameLabel.text = viewModel.people.lastName
        emailLabel.text = viewModel.people.email
        jobTitleLabel.text = viewModel.people.jobTitle

        setImageAvatar()
    }
    
    private func setImageAvatar() {
        viewModel.getImageForUrl(url: viewModel.people.avatar) { data in
            DispatchQueue.main.async {
                self.staffPotrait.image = UIImage(data: data)
            }
        }
    }
}

