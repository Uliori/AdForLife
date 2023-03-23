//
//  AdDetailsViewModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

final class AdDetailsViewModel {
  var title: String?
  var creationDate: String?
  var description: String?
  var isUrgent: Bool?
  var urgentDescription: String?
  var imageUrl: URL?
  var price: String?
  var siret: String?
  
  private let ad: ClassifiedAdModel
  
  init(ad: ClassifiedAdModel) {
    self.ad = ad
    
    setUpBindings()
  }
  
  private func setUpBindings() {
    title = ad.title
    creationDate = L10n.AdDetails.date(AdsDateFormatter.shared.formatDate(ad.creationDate))
    description = ad.description
    isUrgent = ad.isUrgent
    urgentDescription = L10n.AdDetails.urgent
    imageUrl = ad.imagesUrl.thumb
    price = L10n.AdDetails.price(AdsPriceFormatter.shared.formatPrice(ad.price))
    siret = nil
    if let adSiret = ad.siret {
      siret = L10n.AdDetails.siret(adSiret)
    }
  }
}
