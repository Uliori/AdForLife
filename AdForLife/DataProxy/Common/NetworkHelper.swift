//
//  NetworkHelper.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

internal class NetworkHelper {
  
  private enum Constants {
    static let timeout = 30.0

    enum HttpMethods {
      static let get = "GET"
    }
  }
  
  internal static func get(
    url: URL,
    timeoutInterval: TimeInterval? = nil
  ) async throws -> (Data, URLResponse) {
    var request = URLRequest(url: url, timeoutInterval: timeoutInterval ?? Constants.timeout)
    request.httpMethod = Constants.HttpMethods.get
    
    return try await URLSession.shared.data(for: request)
  }
}
