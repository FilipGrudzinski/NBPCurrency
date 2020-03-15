//
//  AlertViewModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol AlertViewModelProtocol: class {
    var delegate: AlertViewModelDelegate! { get set }
    var confirmButtonTitle: String { get }
    var messageText: String { get }
    func confirmDidTap()
}

protocol AlertViewModelDelegate: class { }

final class AlertViewModel {
    weak var delegate: AlertViewModelDelegate!
    
    private let confirmHandler: (() -> ())?
    private let message: String
    
    init(message: String, confirmHandler: (() -> ())?) {
        self.message = message
        self.confirmHandler = confirmHandler
    }
}

extension AlertViewModel: AlertViewModelProtocol {
    var messageText: String { message }
    var confirmButtonTitle: String { Localized.errorAlertButtonText }
    
    func confirmDidTap() {
        confirmHandler?()
    }
}
