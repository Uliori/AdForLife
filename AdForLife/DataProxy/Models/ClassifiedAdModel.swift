//
//  ClassifiedAdModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

public struct ClassifiedAdImage: Decodable {
  var small: String?
  var thumb: String?
}

public struct ClassifiedAdModel: Decodable {
  var id: Int
  var title: String
  var category_id: Int
  var creation_date: String
  var description: String
  var is_urgent: Bool
  var images_url: ClassifiedAdImage
  var price: Float
  var siret: String?
}
