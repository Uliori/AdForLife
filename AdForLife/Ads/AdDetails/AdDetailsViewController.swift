//
//  AdDetailsViewController.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Combine
import UIKit

class AdDetailsViewController: UIViewController {
  
  private let viewModel: AdDetailsViewModel
  private var bindings = Set<AnyCancellable>()

  
  init(viewModel: AdDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    title = "Ad Details"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    view.backgroundColor = .systemBackground
  }
}
