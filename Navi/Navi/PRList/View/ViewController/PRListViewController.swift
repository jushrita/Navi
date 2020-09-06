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
    
    var presenter: PRListPresenter?
    var currentState = PRListViewState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PR List"
        setupPresenter()
    }
    
    func setupPresenter() {
        presenter = PRListPresenter(view: self)
        presenter?.getPRs(forPageNumber: presenter?.currentPageNumber)
    }
    
    func setupView() {
        tableView.reloadData()
    }
}

extension PRListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentState.prListData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PRCell.className, for: indexPath) as? PRCell else {
            return UITableViewCell()
        }
        guard let prData = currentState.prListData?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(data: prData)
        return cell
    }
}

extension PRListViewController: PRListView {
    func renderView(state: PRListViewState) {
        currentState = state
        setupView()
    }
    
    func getCurrentState() -> PRListViewState {
        return currentState
    }
}
