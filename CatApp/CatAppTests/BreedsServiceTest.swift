//
//  BreedsServiceTest.swift
//  CatAppTests
//
//  Created by António Fonseca on 13/05/2024.
//

import XCTest
@testable import CatApp

final class BreedsServiceTest: XCTestCase {
    
    var service: BreedService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        service = BreedsServiceImpl(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        service = nil
        super.tearDown()
    }
    
    func testGetBreedsSuccess() async throws {
        
        guard let url = Bundle.main.url(forResource: "breeds", withExtension: "json") else {
            XCTFail("Failed to load local JSON file")
            return
        }
        
        mockNetworkManager.jsonData = try? Data(contentsOf: url)
        
        do {
            let breeds = try await service.getBreeds(limit: 1, page: 0)
            XCTAssertEqual(breeds.count, 1, "Should return one breed")
            XCTAssertEqual(breeds.first?.name, "Abyssinian", "Fetched breed's name should be 'Abyssinian'")
            XCTAssertEqual(breeds.first?.origin, "Egypt", "Fetched breed's origin should be 'Egypt'")
        } catch {
            XCTFail("Breed fetch failed with error: \(error)")
        }
    }
    
    func testGetBreedsFailure() async throws {
        
        mockNetworkManager.shouldReturnError = true
        
        do {
            let _ = try await service.getBreeds(limit: 1, page: 0)
            XCTFail("Expected error but got success")
        } catch {
            // Success if an error is thrown
            print("Breed fetch failed with error: \(error)")
        }
    }
    
}
