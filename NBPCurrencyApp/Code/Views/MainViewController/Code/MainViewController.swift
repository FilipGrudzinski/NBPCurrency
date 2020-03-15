//
//  MainViewController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class MainViewController: CommonViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    private var viewModel: MainViewModelProtocol
    
    private let refreshControl = UIRefreshControl()
    
    init(with viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onViewDidLoad()
        setupView()
    }
    
    private func setupView() {
        refreshControl.backgroundColor = .white
        view.backgroundColor = .white
        title = viewModel.title
        
        setupRefreshControl()
        setupSegmentControl()
        setupTableView()
        activityIndicator.show()
    }
    
    private func setupRefreshControl() {
        refreshControl.beginRefreshing()
        refreshControl.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupSegmentControl() {
        if #available(iOS 13.0, *) {
            segmentControl.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.registerCellByNib(MainViewTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
      
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @IBAction func segementControlAction(_ sender: Any) {
        activityIndicator.show()
        viewModel.didTapSegment(segmentControl.selectedSegmentIndex)
    }
    
    @objc private func refreshData() {
        viewModel.refreshData(segmentControl.selectedSegmentIndex)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCell(at: indexPath)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainViewTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setupData(viewModel.item(at: indexPath))

        return cell
    }
}

extension MainViewController: MainViewModelDelegate {
    func reloadData() {
        refreshControl.endRefreshing()
        activityIndicator.hide()
        tableView.reloadData()
    }
    
    func setSegment(_ index: Int) {
        segmentControl.selectedSegmentIndex = index
    }
    
    func setSegmentControlData(data: [TablesType]) {
        segmentControl.removeAllSegments()
        data.enumerated().forEach { (index , element) in segmentControl.insertSegment(withTitle: element.tableTitle, at: index, animated: false) }
    }
}
