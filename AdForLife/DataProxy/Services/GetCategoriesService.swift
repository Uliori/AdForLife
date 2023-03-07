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

  init() {}
}

// MARK: - GetCategoriesServiceProtocol

extension GetCategoriesService: GetCategoriesServiceProtocol {
  
  func fetch() async throws -> [CategoryAPIModel] {
    guard let url = URL(string: DataProxyConfiguration.categories) else {
      throw DataProxyError.technical
    }
    let (data, _) = try await NetworkHelper.get(url: url)
    return try JSONDecoder().decode([CategoryAPIModel].self, from: data)
  }
}
