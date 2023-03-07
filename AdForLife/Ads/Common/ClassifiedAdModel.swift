//
//  ClassifiedAdModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

struct ClassifiedAdImageModel: Equatable, Hashable, Decodable {
  var small: URL?
  var thumb: URL?
}

struct ClassifiedAdModel: Equatable, Hashable, Decodable {
  var id: Int
  var title: String
  var categoryId: Int
  var creationDate: Date
  var description: String
  var isUrgent: Bool
  var imagesUrl: ClassifiedAdImageModel
  var price: Float
  var siret: String?
}
