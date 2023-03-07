//
//  AdsUseCase.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation
import Combine

protocol AdsUseCaseProtocol {
  func retrieveAds() -> AnyPublisher<[AdCategoryModel], Error>
}

final class AdsUseCase: AdsUseCaseProtocol {
  func retrieveAds() -> AnyPublisher<[AdCategoryModel], Error> {
    return Future { [weak self] promise in
      guard let self else { return }
      Task {
        guard let categories = try? await GetCategoriesService().fetch() else {
          promise(.failure(DataProxyError.network))
          return
        }
        guard let classifiedAds = try? await GetClassifiedAdsService().fetch() else {
          promise(.failure(DataProxyError.network))
          return
        }
        
        let categoriesEntities = self.convert(categories: categories)
        let classifiedAdsEntities = self.convert(classifiedAds: classifiedAds)
        
        let response: [AdCategoryModel] = categoriesEntities.compactMap { category in
          let ads = classifiedAdsEntities.filter { ad in
            ad.categoryId == category.id
          }
          guard !ads.isEmpty else { return nil }
          return AdCategoryModel(
            id: category.id,
            name: category.name,
            ads: self.convert(classifiedAds: ads)
          )
        }
        promise(.success(response))
      }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
}

// MARK: - Convert

extension AdsUseCase {
  
  private func convert(categories: [CategoryAPIModel]) -> [AdCategoryEntity] {
    categories.map {
      AdCategoryEntity(id: $0.id,
                       name: $0.name)
    }
  }
  
  private func convert(classifiedAds: [ClassifiedAdAPIModel]) -> [ClassifiedAdEntity] {
    classifiedAds.map {
      ClassifiedAdEntity(id: $0.id,
                         title: $0.title,
                         categoryId: $0.categoryId,
                         creationDate: $0.creationDate,
                         description: $0.description,
                         isUrgent: $0.isUrgent,
                         imagesUrl: ClassifiedAdImageEntity(small: $0.imagesUrl.small,
                                                            thumb: $0.imagesUrl.thumb),
                         price: $0.price)
    }
  }
  
  private func convert(classifiedAds: [ClassifiedAdEntity]) -> [ClassifiedAdModel] {
    classifiedAds.map {
      ClassifiedAdModel(id: $0.id,
                        title: $0.title,
                        categoryId: $0.categoryId,
                        creationDate: $0.creationDate,
                        description: $0.description,
                        isUrgent: $0.isUrgent,
                        imagesUrl: ClassifiedAdImageModel(small: $0.imagesUrl.small,
                                                          thumb: $0.imagesUrl.thumb),
                        price: $0.price)
    }
  }
}
