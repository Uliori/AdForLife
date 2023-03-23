//
//  AdCellViewModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

final class AdCellViewModel {
  var image: URL?
  var title: String = ""
  var price: String = ""
  var isUrgent: Bool = false
  
  private let ad: ClassifiedAdModel
  
  init(ad: ClassifiedAdModel) {
    self.ad = ad
    
    setUpBindings()
  }
  
  private func setUpBindings() {
    image = ad.imagesUrl.small
    title = ad.title
    price = AdsPriceFormatter.shared.formatPrice(ad.price)
    isUrgent = ad.isUrgent
  }
}
