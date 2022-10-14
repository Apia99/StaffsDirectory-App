//
//  PeopleDetailsViewModel.swift
//  StaffsDirectory
//
// Created by Hafiz on 12/10/22.
//

import Foundation

class PeopleDetailsViewModel {
    let people:People
    private var imageManager: ImageDownLoader
    init(people:People,
         imageManager: ImageDownLoader = ImageManager()) {
        self.imageManager = imageManager
        self.people = people
    }
    
    func getImageForUrl(url: String, completion: @escaping (Data) -> Void) {
        imageManager.getImage(url: url) { data in
            completion(data)
        }
    }
}
