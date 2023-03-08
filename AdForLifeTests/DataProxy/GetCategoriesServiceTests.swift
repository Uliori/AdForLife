//
//  GetCategoriesServiceTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
@testable import AdForLife

final class GetCategoriesServiceTests: XCTestCase {
  
  private var networkHelperMock: NetworkHelperMock!
  private var sut: GetCategoriesService!
  
  override func setUpWithError() throws {
    networkHelperMock = NetworkHelperMock()
    sut = GetCategoriesService(networkHelper: networkHelperMock)
  }
  
  override func tearDownWithError() throws {
    networkHelperMock = nil
    sut = nil
  }
  
  func test_fetch() async {
    // Given successful json retrieval
    networkHelperMock.result = (
      MockSources.categories.data(using: .utf8) ?? Data(),
      URLResponse()
    )
    // When fetch is requested
    let result = try? await sut.fetch()
    // Then correct result is returned
    XCTAssertEqual(result,
                    [CategoryAPIModel(id: 1,
                                      name: "Véhicule"),
                     CategoryAPIModel(id: 2,
                                       name: "Mode")]
    )
  }
}
