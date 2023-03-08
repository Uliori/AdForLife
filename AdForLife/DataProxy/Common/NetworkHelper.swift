//
//  NetworkHelper.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

protocol NetworkHelperProtocol {
  func get(url: URL, timeoutInterval: TimeInterval?) async throws -> (Data, URLResponse)
}

internal class NetworkHelper: NetworkHelperProtocol {
  static let shared = NetworkHelper()
  
  private enum Constants {
    static let timeout = 30.0

    enum HttpMethods {
      static let get = "GET"
    }
  }
  
  internal func get(
    url: URL,
    timeoutInterval: TimeInterval? = nil
  ) async throws -> (Data, URLResponse) {
    var request = URLRequest(url: url, timeoutInterval: timeoutInterval ?? Constants.timeout)
    request.httpMethod = Constants.HttpMethods.get
    
    return try await URLSession.shared.data(for: request)
  }
}
