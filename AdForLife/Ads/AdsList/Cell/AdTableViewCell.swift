//
//  AdTableViewCell.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation
import UIKit

final class AdTableViewCell: UITableViewCell {
  static let identifier = "AdTableViewCell"
  
  var viewModel: AdCellViewModel! {
    didSet { setUpViewModel() }
  }
  
  let adImage = UIImageView()
  let urgentImage = UIImageView()
  let titleLabel = UILabel()
  let priceLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubiews()
    setUpConstraints()
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addSubiews() {
    let subviews = [adImage, urgentImage, titleLabel, priceLabel]
    
    subviews.forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    selectionStyle = .none
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      adImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
      adImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
      adImage.widthAnchor.constraint(equalToConstant: 80),
      adImage.heightAnchor.constraint(equalToConstant: 80),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
      titleLabel.leadingAnchor.constraint(equalTo: adImage.trailingAnchor, constant: 16.0),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
      
      priceLabel.leadingAnchor.constraint(equalTo: adImage.trailingAnchor, constant: 16.0),
      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
      priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
      
      urgentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
      urgentImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
      urgentImage.widthAnchor.constraint(equalToConstant: 28),
      urgentImage.heightAnchor.constraint(equalToConstant: 28),
    ])
  }
  
  private func configureUI() {
    titleLabel.numberOfLines = 2
    priceLabel.numberOfLines = 1
    
    adImage.backgroundColor = UIColor(named: "adCategoryBackground")
    adImage.contentMode = .scaleAspectFill
    adImage.layer.cornerRadius = 16
    adImage.clipsToBounds = true
    
    urgentImage.contentMode = .scaleAspectFit
  }
  
  private func setUpViewModel() {
    titleLabel.text = viewModel.title
    priceLabel.text = viewModel.price
    
    if let url = viewModel.image {
      adImage.imageFromURL(url, placeHolder: UIImage(named: "lbc"))
    }
    
    urgentImage.image = viewModel.isUrgent ? UIImage(named: "urgent") : nil
  }
}
