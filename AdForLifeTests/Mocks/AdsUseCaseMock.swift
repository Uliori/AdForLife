//
//  AdsUseCaseMock.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation
import Combine
@testable import AdForLife

final class AdsUseCaseMock: AdsUseCaseProtocol {
  var retrieveCallsCount: Int = 0
  var result: Result<[AdForLife.AdCategoryModel], Error> = .success([])
  
  func retrieveAds() -> AnyPublisher<[AdForLife.AdCategoryModel], Error> {
    retrieveCallsCount += 1
    
    return result.publisher.eraseToAnyPublisher()
  }
}
