//
//  ClassifiedAdEntity.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

// NOTE(*): In this case, Entities are simple structures that contains no extra business logic.
//          which is pretty common when most logic is done on the back side,
//          I chose to not add extra logic for images, as I would rather see an ad without image
//          than no ad (debatable)

struct ClassifiedAdImageEntity: Equatable, Hashable, Decodable {
  var small: URL?
  var thumb: URL?
}

struct ClassifiedAdEntity: Equatable, Hashable, Decodable {
  var id: Int
  var title: String
  var categoryId: Int
  var creationDate: Date
  var description: String
  var isUrgent: Bool
  var imagesUrl: ClassifiedAdImageEntity
  var price: Float
  var siret: String?
}
