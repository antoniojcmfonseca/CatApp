//
//  ImageServiceTest.swift
//  CatAppTests
//
//  Created by António Fonseca on 17/05/2024.
//

import XCTest
import AlamofireImage
@testable import CatApp

final class ImageServiceTest: XCTestCase {
    
    var service: ImageService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        service = ImageServiceImpl(networkmanager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        service = nil
        super.tearDown()
    }
    
    func testDownloadImageSuccess() async {
        
        let url = "https://example.com/image.png"
        let expectedImage = Image(systemName: "photo")
        
        let image = await service.getImage(from: url)
        
        XCTAssertNotNil(image)
        XCTAssertEqual(expectedImage, image)
    }
    
    func testDownloadImageFailure() async {
        
        mockNetworkManager.shouldReturnError = true
        
        let url = "https://example.com/image.png"
        
        let image = await service.getImage(from: url)
        
        XCTAssertNil(image)
    }
}
