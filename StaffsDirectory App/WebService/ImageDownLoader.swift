//
//  ImageDownLoader.swift
//  StaffsDirectory
//
//  Created by Hafiz on 12/10/22.
//

import Foundation

protocol ImageDownLoader {
    func getImage(url:String, completion:@escaping (Data)->Void)
}
