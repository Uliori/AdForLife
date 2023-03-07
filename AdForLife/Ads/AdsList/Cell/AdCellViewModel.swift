//
//  AdCellViewModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

final class AdCellViewModel {
  @Published var image: URL?
  @Published var title: String = ""
  @Published var price: String = ""
  @Published var isUrgent: Bool = false
  
  private let ad: ClassifiedAdModel
  
  init(ad: ClassifiedAdModel) {
    self.ad = ad
    
    setUpBindings()
  }
  
  private func setUpBindings() {
    image = ad.imagesUrl.small
    title = ad.title
    price = convertCurrency(ad.price)
    isUrgent = ad.isUrgent
  }
  
  private func convertCurrency(_ amount: Float) -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.locale = Locale.current
    formatter.numberStyle = .currency
    formatter.currencyCode = "EUR"
    return formatter.string(from: NSNumber(value: amount)) ?? ""
  }
}
