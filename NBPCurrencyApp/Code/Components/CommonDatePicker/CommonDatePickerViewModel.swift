//
//  CommonDatePickerViewModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol CommonDatePickerViewModelProtocol: class {
    var delegate: CommonDatePickerViewModelDelegate! { get set }
    var cancelButtonTitle: String { get }
    var confirmButtonTitle: String { get }
    
    func confirmDidTap(date: Date)
    func cancelDidTap()
    func dateValueChanged(with date: Date)
}

protocol CommonDatePickerViewModelDelegate: class {
    
}

final class CommonDatePickerViewModel {
    weak var delegate: CommonDatePickerViewModelDelegate!

    private let confirmHandler: ((Date) -> ())?
    private let cancelHandler: (() -> ())?
    private let dateHandler: ((Date) -> ())?
    
    init(confirmHandler: ((Date) -> ())?, cancelHandler: (() -> ())?, dateHandler: ((Date) -> ())?) {
        self.confirmHandler = confirmHandler
        self.cancelHandler = cancelHandler
        self.dateHandler = dateHandler
    }
}

extension CommonDatePickerViewModel: CommonDatePickerViewModelProtocol {
    var cancelButtonTitle: String { Localized.commonDatePickerCancelButtonTitle }
    var confirmButtonTitle: String { Localized.commonDatePickerConfirmButtonTitle }
    
    func confirmDidTap(date: Date) {
        confirmHandler?(date)
    }
    
    func cancelDidTap() {
        cancelHandler?()
    }
    
    func dateValueChanged(with date: Date) {
        dateHandler?(date)
    }
}
