//
//  AlertViewController.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class AlertViewController: CommonViewController {
    private enum Constants {
        static let cornerRadius: CGFloat = 6.0
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var messageText: UILabel!
    
    private var viewModel: AlertViewModelProtocol
    
    init(with viewModel: AlertViewModelProtocol) {
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
        view.backgroundColor = .none
        messageText.textAlignment = .center
        messageText.textColor = .appCold
        messageText.text = viewModel.messageText
        messageText.numberOfLines = .zero
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadius
        confirmButton.setTitle(viewModel.confirmButtonTitle, for: .normal)
        confirmButton.backgroundColor = .appCold
        confirmButton.tintColor = .white
        confirmButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    @IBAction func confirmTap(_ sender: Any) {
        self.dismiss(animated: true, completion: viewModel.confirmDidTap)
    }
}

extension AlertViewController: AlertViewModelDelegate { }
