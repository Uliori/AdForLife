//
//  AdsListViewController.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import Combine
import UIKit

class AdsListViewController: UIViewController {
  
  private enum Constants {
    enum Colors {
      static let adCategory = UIColor(named: "adCategoryBackground")
    }
  }
  
  private typealias DataSource = UITableViewDiffableDataSource<Int, ClassifiedAdModel>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ClassifiedAdModel>
  
  private let contentView = AdsListView()
  private let viewModel: AdsListViewModel
  private var bindings = Set<AnyCancellable>()
  
  private var dataSource: DataSource!
  var delegate: AdsCoordinatorDelegate?
  
  init(viewModel: AdsListViewModel = AdsListViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    title = "Classified Ads"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    setUpTableView()
    configureDataSource()
    setUpBindings()
    viewModel.retrieve()
  }
  
  private func setUpTableView() {
    contentView.tableView.delegate = self
  }
  
  private func setUpBindings() {
    viewModel.$categories
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] _ in
        self?.updateSections()
      })
      .store(in: &bindings)
    
    let stateValueHandler: (AdsListViewModelState) -> Void = { [weak self] state in
      switch state {
      case .loading:
        self?.contentView.startLoading()
        break
      case .finishedLoading:
        self?.contentView.finishLoading()
        break
      case .error(let error):
        self?.contentView.finishLoading()
        self?.showError(error)
        break
      }
    }
    
    viewModel.$state
      .receive(on: RunLoop.main)
      .sink(receiveValue: stateValueHandler)
      .store(in: &bindings)
  }
  
  private func showError(_ error: Error) {
    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
      self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
  
  private func updateSections() {
    var snapshot = Snapshot()
    for item in viewModel.categories {
      snapshot.appendSections([item.id])
      snapshot.appendItems(item.ads, toSection: item.id)
    }
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  private func configureDataSource() {
    dataSource = DataSource(
      tableView: contentView.tableView,
      cellProvider: { (tableView, indexPath, ad) -> UITableViewCell? in
        let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier,
                                                 for: indexPath) as? AdTableViewCell
        
        cell?.viewModel = AdCellViewModel(ad: ad)
        return cell
      })
    dataSource.defaultRowAnimation = .fade
  }
}

extension AdsListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let category = viewModel.categories[section]
    let view = UIView()
    view.backgroundColor = Constants.Colors.adCategory
    let label = UILabel()
    label.text = category.name
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
      label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
      label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 4)
    ])
    
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    44
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    116
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let ad = viewModel.categories[indexPath.section].ads[indexPath.row]
    delegate?.didSelectAd(ad)
  }
}
