//
//  ImageCacheTests.swift
//  DirectoryAppWithMVVMTests
//
//  Created by Hafiz on 11/10/2022.
//

import XCTest
import UIKit
@testable import StaffsDirectory_App

class ImageCacheTests: XCTestCase {
    var imageCacher: ImageCacher?
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.imageCacher = ImageCacher.shared
    }
    override func tearDownWithError() throws {
        self.imageCacher = nil
        try super.tearDownWithError()
    }
    func testGetImageWhenImageIsNotSaved() {
        // Arrange
        let url = "image_url1"
        // Act
        let imageData = self.imageCacher?.getImage(url:url)
        // Assert
        XCTAssertNil(imageData)
    }
    func testGetImageWhenImageIsSaved() {
        // Arrange
        let url = "image_url"
        let sampleImage = UIImage(named: "poster")?.jpegData(compressionQuality: 1.0) ?? Data()
        // Act
        self.imageCacher?.saveImage(url: url, data: sampleImage)
        
        let pulledImageData = self.imageCacher?.getImage(url: url)
        // Assert
        XCTAssertEqual(pulledImageData, sampleImage)
    }
}
