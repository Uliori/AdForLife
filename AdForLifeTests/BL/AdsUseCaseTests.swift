//
//  AdsUseCaseTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
import Combine
@testable import AdForLife

final class AdsUseCaseTests: XCTestCase {
  
  private var getCategoriesService: GetCategoriesServiceMock!
  private var getClassifiedAdsService: GetClassifiedAdsServiceMock!
  private var sut: AdsUseCase!
  private var cancellables: Set<AnyCancellable> = []
  
  override func setUpWithError() throws {
    getCategoriesService = GetCategoriesServiceMock()
    getClassifiedAdsService = GetClassifiedAdsServiceMock()
    sut = AdsUseCase(getCategoriesService: getCategoriesService,
                     getClassifiedAdsService: getClassifiedAdsService)
  }
  
  override func tearDownWithError() throws {
    getCategoriesService = nil
    getClassifiedAdsService = nil
    sut = nil
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
  
  // MARK: - Fetch - Fail
  
  func test_fetch_error_01() {
    // Given: user wants to retrieve Ads AND categories service is not functional
    let expectation = XCTestExpectation(description: "Categories error is set to network")
    getCategoriesService.error = DataProxyError.network
    // When: fetch is requested
    sut.retrieveAds()
      .sink { completion in
        guard case let .failure(error) = completion else {
          XCTFail("Test should fail")
          return
        }
        // Then: an error is raised
        XCTAssertEqual(error as? DataProxyError, DataProxyError.network)
        expectation.fulfill()
      } receiveValue: { result in
        XCTFail("Test should fail")
      }
      .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1)
  }
  
  func test_fetch_error_02() {
    // Given: user wants to retrieve Ads AND ads service is not functional
    let expectation = XCTestExpectation(description: "Ads error is set to network")
    getClassifiedAdsService.error = DataProxyError.network
    // When: fetch is requested
    sut.retrieveAds()
      .sink { completion in
        guard case let .failure(error) = completion else {
          XCTFail("Test should fail")
          return
        }
        // Then: an error is raised
        XCTAssertEqual(error as? DataProxyError, DataProxyError.network)
        expectation.fulfill()
      } receiveValue: { result in
        XCTFail("Test should fail")
      }
      .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1)
  }
  
  // MARK: - Fetch - Success
  
  func test_fetch_success() {
    // Given: user wants to retrieve Ads
    let expectation = XCTestExpectation(description: "Retrieve is successful")
    let adDate = Date()
    getClassifiedAdsService.result = [ClassifiedAdAPIModel(
      id: 123456,
      title: "Velo course Gitane taille 61 cm , 12 vitesses",
      categoryId: 1,
      creationDate: adDate,
      description: "description",
      isUrgent: true,
      imagesUrl: ClassifiedAdImageAPIModel(
        small: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg"),
        thumb: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg")),
      price: 180
    )]
    getCategoriesService.result = [CategoryAPIModel(id: 1,
                                                    name: "Véhicule")]
    
    // When: fetch is requested
    sut.retrieveAds()
      .sink { completion in
        guard case .finished = completion else {
          XCTFail("Test should not fail")
          return
        }
      } receiveValue: { result in
        // Then: Correct result is output
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first,
                       AdCategoryModel(id: 1,
                                       name: "Véhicule",
                                       ads: [ClassifiedAdModel(id: 123456,
                                                               title: "Velo course Gitane taille 61 cm , 12 vitesses",
                                                               categoryId: 1,
                                                               creationDate: adDate,
                                                               description: "description",
                                                               isUrgent: true,
                                                               imagesUrl: ClassifiedAdImageModel(
                                                                small:  URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg"),
                                                                thumb: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg")),
                                                               price: 180)]))
        
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    wait(for: [expectation], timeout: 1)
  }
}
