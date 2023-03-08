//
//  NetworkHelperMock.swift
//  AdForLifeTests
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation
@testable import AdForLife

final class NetworkHelperMock: NetworkHelperProtocol {
  var getCallsCount: Int = 0
  
  var result: (Data, URLResponse) = (Data(), URLResponse())
  
  func get(url: URL, timeoutInterval: TimeInterval?) async throws -> (Data, URLResponse) {
    getCallsCount += 1
    return result
  }
}
