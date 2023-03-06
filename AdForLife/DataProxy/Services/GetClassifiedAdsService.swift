//
//  GetClassifiedAdsService.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

public protocol GetClassifiedAdsServiceProtocol {
  func fetch() async throws -> [ClassifiedAdModel]
}

final class GetClassifiedAdsService {

  init() {}
}

// MARK: - GetClassifiedAdsServiceProtocol

extension GetClassifiedAdsService: GetClassifiedAdsServiceProtocol {
  
  func fetch() async throws -> [ClassifiedAdModel] {
    guard let url = URL(string: DataProxyConfiguration.listing) else {
      throw DataProxyError.technical
    }
    let (data, _) = try await NetworkHelper.get(url: url)
    return try JSONDecoder().decode([ClassifiedAdModel].self, from: data)
  }
}