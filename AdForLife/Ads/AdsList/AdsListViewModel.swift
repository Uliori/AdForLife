//
//  AdsListViewModel.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Combine
import Foundation

enum AdsListViewModelError: Error, Equatable {
  case fetchError
}

enum AdsListViewModelState: Equatable {
  case loading
  case finishedLoading
  case error(AdsListViewModelError)
}

final class AdsListViewModel {
  @Published private(set) var categories: [AdCategoryModel] = []
  @Published private(set) var state: AdsListViewModelState = .loading
  
  private let adsUseCase: AdsUseCaseProtocol
  private var bindings = Set<AnyCancellable>()
  
  init(adsUseCase: AdsUseCaseProtocol = AdsUseCase()) {
    self.adsUseCase = adsUseCase
  }
  
  func retrieve() {
    fetchAds()
  }
  
  private func fetchAds() {
    state = .loading
    
    let searchTermCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
      switch completion {
      case .failure:
        self?.state = .error(.fetchError)
      case .finished:
        self?.state = .finishedLoading
      }
    }
    
    let searchTermValueHandler: ([AdCategoryModel]) -> Void = { [weak self] categories in
      // NOTE(*): Order categories alphabetically
      self?.categories = categories.sorted(by: { lI, rT in
        lI.name < rT.name
      })
    }
    
    // NOTE(*): Delay was added to show loader, just to simulate a longer call
    adsUseCase
      .retrieveAds()
      .delay(for: .seconds(0.3), scheduler: RunLoop.main)
      .sink(receiveCompletion: searchTermCompletionHandler, receiveValue: searchTermValueHandler)
      .store(in: &bindings)
  }
}
