//
//  AppCoordinator.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Foundation
import UIKit

class AppCoordinator {
  
  // MARK: - Properties
  
  let window: UIWindow?
  let rootViewController = UINavigationController()
  
  // MARK: - Constructor
  
  init(window: UIWindow?) {
    self.window = window
  }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {
  
  func start() {
    guard let window = window else {
      return
    }
    
    let adsCoordinator = AdsCoordinator(rootViewController: rootViewController)
    adsCoordinator.start()
    
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
}
