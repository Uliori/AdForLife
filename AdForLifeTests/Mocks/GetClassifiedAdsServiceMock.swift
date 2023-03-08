//
//  GetClassifiedAdsServiceMock.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation
@testable import AdForLife

final class GetClassifiedAdsServiceMock: GetClassifiedAdsServiceProtocol {
  var fetchCallsCount: Int = 0
  
  var result: [AdForLife.ClassifiedAdAPIModel] = []
  var error: Error?
  
  func fetch() async throws -> [AdForLife.ClassifiedAdAPIModel] {
    fetchCallsCount += 1
    if let error {
      throw error
    }
    return result
  }
}
