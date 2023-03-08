//
//  AdCellViewModelTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
import Combine
@testable import AdForLife

final class AdCellViewModelTests: XCTestCase {
  private var sut: AdCellViewModel!
  let adDate = Date()
  
  override func setUpWithError() throws {
    sut = AdCellViewModel(ad: ClassifiedAdModel(id: 123456,
                                                title: "Velo course Gitane taille 61 cm , 12 vitesses",
                                                categoryId: 1,
                                                creationDate: adDate,
                                                description: "description",
                                                isUrgent: true,
                                                imagesUrl: ClassifiedAdImageModel(
                                                  small:  URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg"),
                                                  thumb: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg")),
                                                price: 180))
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  // MARK: Test - Init
  
  func test_init() {
    XCTAssertEqual(sut.title, "Velo course Gitane taille 61 cm , 12 vitesses")
    XCTAssertEqual(sut.isUrgent, true)
    XCTAssertEqual(sut.image, URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg"))
    XCTAssertEqual(sut.price, AdsPriceFormatter.shared.formatPrice(180))
  }
}
