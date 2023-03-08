//
//  GetCategoriesService.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

public protocol GetCategoriesServiceProtocol {
  func fetch() async throws -> [CategoryAPIModel]
}

final class GetCategoriesService {
  private let networkHelper: NetworkHelperProtocol
  
  init(networkHelper: NetworkHelperProtocol = NetworkHelper.shared) {
    self.networkHelper = networkHelper
  }
}

// MARK: - GetCategoriesServiceProtocol

extension GetCategoriesService: GetCategoriesServiceProtocol {
  
  func fetch() async throws -> [CategoryAPIModel] {
    guard let url = URL(string: DataProxyConfiguration.categories) else {
      throw DataProxyError.technical
    }
    let (data, _) = try await networkHelper.get(url: url, timeoutInterval: nil)
    return try JSONDecoder().decode([CategoryAPIModel].self, from: data)
  }
}
