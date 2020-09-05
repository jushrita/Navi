//
//  PRListViewController.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import UIKit

class PRListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: PRCell.className, bundle: nil), forCellReuseIdentifier: PRCell.className)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PR List"
    }
}

extension PRListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: PRCell.className, for: indexPath) as? PRCell else {
           return UITableViewCell()
       }
       return cell
    }
}
