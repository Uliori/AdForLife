//
//  AdDetailsViewModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation

final class AdDetailsViewModel {
  
  private let ad: ClassifiedAdModel
  
  init(ad: ClassifiedAdModel) {
    self.ad = ad
    
    setUpBindings()
  }
  
  private func setUpBindings() {
  }
}
