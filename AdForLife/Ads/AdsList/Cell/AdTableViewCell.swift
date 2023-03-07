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
  
  lazy var titleLabel = UILabel()
  lazy var priceLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubiews()
    setUpConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addSubiews() {
    let subviews = [titleLabel, priceLabel]
    
    subviews.forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
      
      priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      priceLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10.0),
      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
      priceLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
    ])
  }
  
  private func setUpViewModel() {
    titleLabel.text = viewModel.title
    priceLabel.text = viewModel.price
  }
}
