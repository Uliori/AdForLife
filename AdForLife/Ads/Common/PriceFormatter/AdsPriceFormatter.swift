//
//  AdsPriceFormatter.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

class AdsPriceFormatter {
  static let shared = AdsPriceFormatter()
  
  func formatPrice(_ amount: Float, currencyCode: String = "EUR") -> String {
    let preferredLanguage = Locale.preferredLanguages.first ?? "fr"
    let locale = Locale(identifier: preferredLanguage)
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.usesGroupingSeparator = true
    formatter.locale = locale
    formatter.currencyCode = currencyCode
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter.string(for: amount) ?? ""
  }
}
