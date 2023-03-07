//
//  ClassifiedAdAPIModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation

public struct ClassifiedAdImageAPIModel: Decodable {
  var small: URL?
  var thumb: URL?
  
  enum CodingKeys: CodingKey {
    case small
    case thumb
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let smallURLString = try container.decodeIfPresent(String.self,
                                                          forKey: .small),
       let smallURL = URL(string: smallURLString) {
      small = smallURL
    }
    if let thumbURLString = try container.decodeIfPresent(String.self,
                                                          forKey: .thumb),
       let thumbURL = URL(string: thumbURLString) {
      thumb = thumbURL
    }
  }
}

public struct ClassifiedAdAPIModel: Decodable {
  var id: Int
  var title: String
  var categoryId: Int
  var creationDate: Date
  var description: String
  var isUrgent: Bool
  var imagesUrl: ClassifiedAdImageAPIModel
  var price: Float
  var siret: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case categoryId = "category_id"
    case title
    case description
    case price
    case imagesUrl = "images_url"
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
    case siret
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    categoryId = try container.decode(Int.self, forKey: .categoryId)
    title = try container.decode(String.self, forKey: .title)
    description = try container.decode(String.self, forKey: .description)
    price = try container.decode(Float.self, forKey: .price)
    imagesUrl = try container.decode(ClassifiedAdImageAPIModel.self, forKey: .imagesUrl)

    let dateString = try container.decode(String.self, forKey: .creationDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    guard let date = dateFormatter.date(from: dateString) else {
      throw DecodingError.dataCorruptedError(forKey: .creationDate,
                                             in: container,
                                             debugDescription: "Incorrect date format")
    }
    self.creationDate = date

    isUrgent = try container.decode(Bool.self, forKey: .isUrgent)
    siret = try container.decodeIfPresent(String.self, forKey: .siret)
  }
}
