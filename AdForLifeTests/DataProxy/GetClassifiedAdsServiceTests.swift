//
//  GetClassifiedAdsServiceTests.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import XCTest
@testable import AdForLife

final class GetClassifiedAdsServiceTests: XCTestCase {

  private var networkHelperMock: NetworkHelperMock!
  private var sut: GetClassifiedAdsService!
  
  override func setUpWithError() throws {
    networkHelperMock = NetworkHelperMock()
    sut = GetClassifiedAdsService(networkHelper: networkHelperMock)
  }
  
  override func tearDownWithError() throws {
    networkHelperMock = nil
    sut = nil
  }
  
  func test_fetch() async {
    // Given successful json retrieval
    networkHelperMock.result = (
      MockSources.ads.data(using: .utf8) ?? Data(),
      URLResponse()
    )
    // When fetch is requested
    let result = try? await sut.fetch()
    // Then correct result is returned
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    XCTAssertEqual(result,
                    [ClassifiedAdAPIModel(id: 1461267313,
                                          title: "Statue homme noir assis en plâtre polychrome",
                                          categoryId: 4,
                                          creationDate: dateFormatter.date(from: "2019-11-05T15:56:59+0000")!,
                                          description: "Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
                                          isUrgent: false,
                                          imagesUrl: ClassifiedAdImageAPIModel(
                                            small: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"),
                                            thumb: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")),
                                          price: 140.00)]
    )
  }
}
