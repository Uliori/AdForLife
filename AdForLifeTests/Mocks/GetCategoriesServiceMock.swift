//
//  GetCategoriesServiceMock.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation
@testable import AdForLife

final class GetCategoriesServiceMock: GetCategoriesServiceProtocol {
  var fetchCallsCount: Int = 0
  
  var result: [AdForLife.CategoryAPIModel] = []
  var error: Error?
  
  func fetch() async throws -> [AdForLife.CategoryAPIModel] {
    fetchCallsCount += 1
    if let error {
      throw error
    }
    return result
  }
}
