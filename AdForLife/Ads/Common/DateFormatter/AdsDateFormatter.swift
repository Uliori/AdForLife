//
//  AdsDateFormatter.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 08/03/2023.
//

import Foundation

class AdsDateFormatter {
  static let shared = AdsDateFormatter()
  
  func formatDate(_ date: Date, style: DateFormatter.Style = .medium) -> String {
    let preferredLanguage = Locale.preferredLanguages.first ?? "fr"
    let locale = Locale(identifier: preferredLanguage)
    
    let formatter = DateFormatter()
    formatter.dateStyle = style
    return formatter.string(from: date)
  }
}
