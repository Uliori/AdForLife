//
//  AdCategoryEntity.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

// NOTE(*): In this case, Entities are simple structures that contains no extra business logic.
//          which is pretty common when most logic is done on the back side.

struct AdCategoryEntity: Equatable, Hashable, Decodable {
  var id: Int
  var name: String
}
