//
//  AdsListView.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 07/03/2023.
//

import Foundation
import UIKit

final class AdsListView: UIView {
  
  let activityIndicationView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.color = .orange
    return activityIndicator
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(AdTableViewCell.self,
                       forCellReuseIdentifier: AdTableViewCell.identifier)
    return tableView
  }()
  
  init() {
    super.init(frame: .zero)
    
    addSubviews()
    setUpConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startLoading() {
    tableView.isUserInteractionEnabled = false
    
    activityIndicationView.isHidden = false
    activityIndicationView.startAnimating()
  }
  
  func finishLoading() {
    tableView.isUserInteractionEnabled = true
    
    activityIndicationView.isHidden = true
    activityIndicationView.stopAnimating()
  }
  
  private func addSubviews() {
    backgroundColor = .white
    let subviews = [tableView, activityIndicationView]
    
    subviews.forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
      activityIndicationView.heightAnchor.constraint(equalToConstant: 50.0),
      activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
    ])
  }
}
