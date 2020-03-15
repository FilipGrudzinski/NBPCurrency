//
//  InViewControllerHelper.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 15/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

enum InViewControllerHelper {
    static let inView =  InViewService()
    
    case commonDatePicker(confirmHandler: ((Date) -> ())? = nil, cancelHandler: (() -> ())? = nil, dateHandler: ((Date) -> ())? = nil, controller: UIViewController)
    
    enum SubType {
        case datePicker
    }
    
    func presentIn() {
        switch self {
        case let .commonDatePicker(confirmHandler, cancelHandler, dateHandler, controller):
            InViewControllerHelper.inView.create(type: .datePicker, confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler, controller)
        }
    }
}

final class InViewService {
    
    @discardableResult
    func create( type: InViewControllerHelper.SubType, confirmHandler: ((Date) -> ())?, cancelHandler: (() -> ())?, dateHandler: ((Date) -> ())?, _ controller: UIViewController) -> CommonViewController {
        switch type {
        case .datePicker:
            return createDatePicker(confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler, controller)
        }
    }
    
    private func createDatePicker(confirmHandler: ((Date) -> ())?, cancelHandler: (() -> ())?, dateHandler: ((Date) -> ())?, _ controller: UIViewController) -> CommonViewController {
        let viewModel = CommonDatePickerViewModel(confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler)
        let inViewController = CommonDatePickerViewController(with: viewModel)
        inViewController.modalPresentationStyle = .custom
        controller.present(inViewController, animated: true)
        return inViewController
    }
}
