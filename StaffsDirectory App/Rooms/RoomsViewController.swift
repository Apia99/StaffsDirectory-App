//
//  RoomsViewController.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import UIKit

class RoomsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var roomsViewModel:RoomsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsViewModel = RoomsViewModel()
        activityIndicator.startAnimating()

        roomsViewModel.fetchRooms(baseUrl: EndPoint.baseUrl, path: Path.rooms)
        
        roomsViewModel.refreshView =  {
            DispatchQueue.main.async{
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        roomsViewModel.showError = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

extension RoomsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsViewModel.roomsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsTableViewCell else {
            return UITableViewCell()
        }
        
        if let room = roomsViewModel.getRoomFor(index: indexPath.row) {
            cell.setData(room: room)
        }
        return cell
    }
}
