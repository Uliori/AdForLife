//
//  AdDetailsViewModelTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
import Combine
@testable import AdForLife

final class AdDetailsViewModelTests: XCTestCase {
  
  private var sut: AdDetailsViewModel!
  let adDate = Date()
  
  override func setUpWithError() throws {
    sut = AdDetailsViewModel(ad: ClassifiedAdModel(id: 123456,
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
    XCTAssertEqual(sut.creationDate, L10n.AdDetails.date(AdsDateFormatter.shared.formatDate(adDate)))
    XCTAssertEqual(sut.description, "description")
    XCTAssertEqual(sut.isUrgent, true)
    XCTAssertEqual(sut.urgentDescription, L10n.AdDetails.urgent)
    XCTAssertEqual(sut.imageUrl, URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/6f734e6d789a26f768aa6eaa856ea7fef0f82282.jpg"))
    XCTAssertEqual(sut.price, L10n.AdDetails.price(AdsPriceFormatter.shared.formatPrice(180)))
    XCTAssertNil(sut.siret)
  }
}
