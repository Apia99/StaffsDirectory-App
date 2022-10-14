//
//  PeoplesViewController.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import UIKit

final class PeoplesViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
   
    var peopleViewModel:PeoplesViewModel!
    weak var coordinator: PeoplesCoordinatoryType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()

        peopleViewModel.fetchPeoples(baseUrl: EndPoint.baseUrl, path: Path.people)
        
        peopleViewModel.refreshView = {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        peopleViewModel.showError = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }    
}

extension PeoplesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleViewModel.peoplessCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PeopleTableViewCell else{return UITableViewCell()}
       
        if let people = peopleViewModel.getPeopleDetailFor(index: indexPath.row) {
            cell.setData(staff: people)
            peopleViewModel.getImageForUrl(url: people.avatar) { data in
                DispatchQueue.main.async {
                    cell.imageAvatar.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
}

extension PeoplesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let staff = peopleViewModel.getPeopleDetailFor(index: indexPath.row) {
            coordinator.navigatToPeopleDetails(people: staff)
        }
    }
}
