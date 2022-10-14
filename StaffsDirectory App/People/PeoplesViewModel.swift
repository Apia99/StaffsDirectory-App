//
//  PeoplesViewModel.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

protocol PeopleViewModelType: AnyObject {
    var peoplessCount:Int { get }
    func fetchPeoples(baseUrl: String, path: String)
    func getPeopleDetailFor(index:Int)-> People?
    func getImageForUrl(url: String, completion: @escaping(Data)-> Void)
}

final class PeoplesViewModel {

    private var peoples:[PeopleResponce] = []
    var peoplessCount:Int {
        return peoples.count
    }
    private var serviceManager: Servicable
    private var imageManager: ImageDownLoader
    var refreshView:(()-> ())?
    var showError:(()-> ())?
    init(serviceManager: Servicable = ServiceManager(),
         imageManager: ImageDownLoader = ImageManager()) {
        self.serviceManager = serviceManager
        self.imageManager = imageManager
    }
}
extension PeoplesViewModel: PeopleViewModelType {
    func fetchPeoples(baseUrl: String, path: String) {
        serviceManager.get(baseUrl, path: path, type: [PeopleResponce].self) {[weak self] result in
            switch result {
            case .success(let peoples) :
                self?.peoples = peoples
                self?.refreshView?()
            case .failure(_) :
                self?.peoples = []
                self?.showError?()
            }
        }
    }
    func getPeopleDetailFor(index: Int)-> People? {
        guard index < peoplessCount && index >= 0 else {
            return nil
        }
        let people = peoples[index]
        return People(firstName: people.firstName ?? "", avatar: people.avatar ?? "", lastName: people.lastName ?? "", email: people.email ?? "", jobTitle: people.jobTitle ?? "", joinedDate: people.createdAt ?? "")
    }
    func getImageForUrl(url: String, completion: @escaping (Data) -> Void) {
        imageManager.getImage(url: url) { data in
            completion(data)
        }
    }
}

