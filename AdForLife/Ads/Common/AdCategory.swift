//
//  AdCategoryModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

struct AdCategoryModel: Equatable, Hashable, Decodable {
  var id: Int
  var name: String
  
  var ads: [ClassifiedAdModel]
}
