//
//  L10n.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation

enum L10n {
  private static func localized(key: String, _ args: CVarArg...) -> String {
    let format = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    return String(format: format, arguments: args)
  }
  
  enum AdsList {
    static let title: String = L10n.localized(key: "adsList.title")
  }
  
  enum AdDetails {
    static let title: String = L10n.localized(key: "adDetails.title")
    static func price(_ a1: Any) -> String {
      L10n.localized(key: "adDetails.price", String(describing: a1))
    }
    static func date(_ a1: Any) -> String {
      L10n.localized(key: "adDetails.date", String(describing: a1))
    }
    static func siret(_ a1: Any) -> String {
      L10n.localized(key: "adDetails.siret", String(describing: a1))
    }
    static let urgent: String = L10n.localized(key: "adDetails.urgent")
  }
}
