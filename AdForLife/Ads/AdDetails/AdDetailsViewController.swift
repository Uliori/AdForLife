//
//  AdDetailsViewController.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Combine
import UIKit

class AdDetailsViewController: UIViewController {
  
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    return scrollView
  }()
  
  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 8
    return stackView
  }()
  
  let urgentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 8
    return stackView
  }()
  
  let adImage = UIImageView()
  let urgentImage = UIImageView()
  let urgentLabel = UILabel()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let dateLabel = UILabel()
  let priceLabel = UILabel()
  let siretLabel = UILabel()
  
  private let viewModel: AdDetailsViewModel

  init(viewModel: AdDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    title = L10n.AdDetails.title
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    view.backgroundColor = .systemBackground
    
    addSubiews()
    setUpConstraints()
    configureUI()
    setUpViewModel()
  }
  
  private func addSubiews() {
    view.addSubview(scrollView)

    scrollView.addSubview(stackView)

    let subviews = [
      adImage,
      titleLabel,
      dateLabel,
      urgentStackView,
      descriptionLabel,
      siretLabel,
      priceLabel
    ]
    
    let urgentSubviews = [
      urgentImage,
      urgentLabel
    ]

    urgentSubviews.forEach {
      urgentStackView.addArrangedSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    subviews.forEach {
      stackView.addArrangedSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ])
    NSLayoutConstraint.activate([
      adImage.widthAnchor.constraint(equalTo: view.widthAnchor),
      adImage.heightAnchor.constraint(equalTo: view.widthAnchor),
      
      urgentImage.widthAnchor.constraint(equalToConstant: 28),
      urgentImage.heightAnchor.constraint(equalToConstant: 28),
    ])
    
    NSLayoutConstraint.activate([
      titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
      descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
      dateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
      priceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
      siretLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
      urgentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
    ])
  }
  
  private func configureUI() {
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
    priceLabel.numberOfLines = 0
    priceLabel.textAlignment = .right
    priceLabel.font = UIFont.preferredFont(forTextStyle: .title3)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
    
    adImage.backgroundColor = UIColor(named: "adCategoryBackground")
    adImage.contentMode = .scaleAspectFill
    adImage.clipsToBounds = true
    
    urgentImage.contentMode = .scaleAspectFit
    
    titleLabel.textAlignment = .left
    descriptionLabel.textAlignment = .left
    dateLabel.textAlignment = .left
    priceLabel.textAlignment = .left
    siretLabel.textAlignment = .left
  }
  
  private func setUpViewModel() {
    titleLabel.text = viewModel.title
    priceLabel.text = viewModel.price
    descriptionLabel.text = viewModel.description
    dateLabel.text = viewModel.creationDate
    siretLabel.text = viewModel.siret
    urgentLabel.text = viewModel.urgentDescription
    
    if let url = viewModel.imageUrl {
      adImage.imageFromURL(url, placeHolder: UIImage(named: "lbc"))
    }
    
    urgentStackView.isHidden = !(viewModel.isUrgent ?? false)
    urgentImage.image = (viewModel.isUrgent ?? false) ? UIImage(named: "urgent") : nil
  }
}
