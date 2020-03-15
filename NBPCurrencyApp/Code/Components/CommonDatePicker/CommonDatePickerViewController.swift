//
//  CommonDatePickerViewController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class CommonDatePickerViewController: CommonViewController {
    private enum Constants {
        static let bacgroundColor = UIColor.black.withAlphaComponent(0.2)
        static let cornerRadius: CGFloat = 6.0
    }
    
    @IBOutlet private weak var pickerView: UIView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    private var viewModel: CommonDatePickerViewModelProtocol
    
    init(with viewModel: CommonDatePickerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = Constants.bacgroundColor
        pickerView.backgroundColor = .white
        pickerView.layer.cornerRadius = Constants.cornerRadius
        cancelButton.setTitle(viewModel.cancelButtonTitle, for: .normal)
        confirmButton.setTitle(viewModel.confirmButtonTitle, for: .normal)
        cancelButton.backgroundColor = .appCold
        cancelButton.tintColor = .white
        cancelButton.layer.cornerRadius = Constants.cornerRadius
        confirmButton.backgroundColor = .appCold
        confirmButton.tintColor = .white
        confirmButton.layer.cornerRadius = Constants.cornerRadius
        
        if #available(iOS 11.0, *) {
            pickerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        setupPicker()
        datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    private func setupPicker() {
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
    }
    
    @objc private func valueChanged() {
        viewModel.dateValueChanged(with: datePicker.date)
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: viewModel.cancelDidTap )
        
    }
    
    @IBAction func confirmTap(_ sender: Any) {
        viewModel.confirmDidTap(date: datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CommonDatePickerViewController: CommonDatePickerViewModelDelegate {
    
}
