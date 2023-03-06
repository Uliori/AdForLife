//
//  AdsListViewController.swift
//  AdForLife
//
//  Created by El Mehdi KHALLOUKI on 06/03/2023.
//

import UIKit

class AdsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      view.backgroundColor = .red
      
      Task {
        do {
          print(try await GetCategoriesService().fetch())
          print(try await GetClassifiedAdsService().fetch())
        } catch {
          print(error)
        }
      }
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
