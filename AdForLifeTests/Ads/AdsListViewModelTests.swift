//
//  AdsListViewModelTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
import Combine
@testable import AdForLife

final class AdsListViewModelTests: XCTestCase {
  
  private var sut: AdsListViewModel!
  private var adsUseCaseMock: AdsUseCaseMock!
  private var cancellables: Set<AnyCancellable> = []
  
  override func setUpWithError() throws {
    adsUseCaseMock = AdsUseCaseMock()
    sut = AdsListViewModel(adsUseCase: adsUseCaseMock)
  }
  
  override func tearDownWithError() throws {
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
    adsUseCaseMock = nil
    sut = nil
  }
  
  // MARK: - Retrieve - Error
  
  func test_retrieve_error() {
    // Given use case retrieval fails
    adsUseCaseMock.result = .failure(DataProxyError.network)
    
    // When retrie is requested
    sut.retrieve()
    
    // Then fetch error is output
    XCTAssertEqual(adsUseCaseMock.retrieveCallsCount, 1)
    sut.$categories
      .sink { XCTAssertEqual($0, []) }
      .store(in: &cancellables)
    
    sut.$state
      .delay(for: .seconds(0.3), scheduler: RunLoop.main)
      .sink { XCTAssertEqual($0, .error(AdsListViewModelError.fetchError)) }
      .store(in: &cancellables)
  }
  
  // MARK: - Retrieve - Success
  
  func test_retrieve_success() {
    // Given use case retrieval succeed
    let adDate = Date()
    let ads = [
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
                                              price: 180)])
    ]
    adsUseCaseMock.result = .success(ads)
    
    // When retrie is requested
    sut.retrieve()
    
    // Then correct result is output
    XCTAssertEqual(adsUseCaseMock.retrieveCallsCount, 1)
    sut.$categories
      .delay(for: .seconds(0.3), scheduler: RunLoop.main)
      .sink { XCTAssertEqual($0, ads) }
      .store(in: &cancellables)
    
    sut.$state
      .delay(for: .seconds(0.3), scheduler: RunLoop.main)
      .sink { XCTAssertEqual($0, .finishedLoading) }
      .store(in: &cancellables)
  }
}
