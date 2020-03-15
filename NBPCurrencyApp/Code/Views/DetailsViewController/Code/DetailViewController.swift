//
//  DetailViewController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class DetailViewController: CommonViewController {
    private enum Constants {
        static let cornerRadius: CGFloat = 6.0
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var startDateTextField: UITextField!
    @IBOutlet private weak var endDateTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    
    private var viewModel: DetailViewModelProtocol
    
    private let refreshControl = UIRefreshControl()
    
    init(with viewModel: DetailViewModelProtocol) {
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
        title = viewModel.title
        refreshControl.backgroundColor = .white
        view.backgroundColor = .white
        
        setupSearchButton()
        setupRefreshControl()
        setupTableView()
        setupTextFields()
        activityIndicator.show()
    }
    
    private func setupSearchButton() {
        searchButton.backgroundColor = .appCold
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = Constants.cornerRadius
        searchButton.isEnabled = false
        searchButton.setTitle(viewModel.searchButtonText, for: .normal)
    }
    
    private func setupTextFields() {
        startDateTextField.clearButtonMode = .always
        endDateTextField.clearButtonMode = .always
        startDateTextField.tag = TextFieldType.start.rawValue
        endDateTextField.tag = TextFieldType.end.rawValue
        startDateTextField.addTarget(self, action: #selector(textFieldTouch), for: .touchDown)
        endDateTextField.addTarget(self, action: #selector(textFieldTouch), for: .touchDown)
        startDateTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        endDateTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupRefreshControl() {
        refreshControl.beginRefreshing()
        refreshControl.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.registerCellByNib(DetailViewTableViewCell.self)
        tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func unlockSearchButton() {
        guard let startText = startDateTextField.text, startText.isNotEmpty, let endText = endDateTextField.text, endText.isNotEmpty else {
            searchButton.isEnabled = false
            return
        }
        searchButton.isEnabled = true
    }
    
    @IBAction func searchButtonTap(_ sender: Any) {
        activityIndicator.show()
        viewModel.searchDateData()
    }
    
    @objc private func refreshData() {
        viewModel.refreshData()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.textDidChangeClosure(text: textField.text ?? .empty, index: textField.tag)
        unlockSearchButton()
    }
    
    @objc func textFieldTouch(_ textField: UITextField) {
        viewModel.selectTextFieldPick(index: textField.tag)
        InViewControllerHelper.commonDatePicker(confirmHandler: viewModel.updateDatePickerHandler, cancelHandler: unlockSearchButton, dateHandler: viewModel.updateDatePickerHandler, controller: self).presentIn()
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailViewTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setupData(viewModel.item(at: indexPath))
        
        return cell
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func presentAlert(message: String) {
        InViewControllerHelper.commonAlert(message: message, confirmHandler: {
            self.activityIndicator.hide()
            self.viewModel.clearData()
        }, controller: self).presentIn()
    }
    
    func reloadData() {
        refreshControl.endRefreshing()
        activityIndicator.hide()
        tableView.reloadData()
    }
    
    func updateTextField(text: String, selected: Int) {
        switch selected {
        case TextFieldType.end.rawValue:
            endDateTextField.text = text
        case TextFieldType.start.rawValue:
            startDateTextField.text = text
        default: ()
        }
        unlockSearchButton()
    }
}
