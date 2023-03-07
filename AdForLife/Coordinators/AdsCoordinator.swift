//
//  AdsCoordinator.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation
import UIKit

// NOTE(*): Coordinators might need to save/register child coordinators, but for LBC test case, where we only have
//          Ad List and Ad details, one Coordinator is enough, so no extra methods/logic is needed

protocol AdsCoordinatorDelegate {
  func didSelectAd(_ ad: ClassifiedAdModel)
}

class AdsCoordinator {
  
  // MARK: - Properties
  
  weak var rootViewController: UINavigationController?
  
  // MARK: - Constructor
  
  init(rootViewController: UINavigationController?) {
    self.rootViewController = rootViewController
  }
}

// MARK: - Coordinator

extension AdsCoordinator: Coordinator {
  
  func start() {
    let adsListViewController = AdsListViewController()
    adsListViewController.delegate = self
    rootViewController?.setViewControllers([adsListViewController], animated: false)
  }
}

// MARK: - AdsCoordinatorDelegate

extension AdsCoordinator: AdsCoordinatorDelegate {
  func didSelectAd(_ ad: ClassifiedAdModel) {
    let viewModel = AdDetailsViewModel(ad: ad)
    let adDetailsViewController = AdDetailsViewController(viewModel: viewModel)
    rootViewController?.pushViewController(adDetailsViewController, animated: true)
  }
}
