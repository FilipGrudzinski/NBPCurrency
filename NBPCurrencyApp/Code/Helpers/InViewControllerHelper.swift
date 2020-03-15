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
    case commonAlert(message: String, confirmHandler: (() -> ())? = nil, controller: UIViewController)
    
    enum SubType {
        case datePicker
        case alertView
    }
    
    func presentIn() {
        switch self {
        case let .commonDatePicker(confirmHandler, cancelHandler, dateHandler, controller):
            InViewControllerHelper.inView.create(message: .empty, type: .datePicker, confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler, controller)
        case let .commonAlert(message, confirmHandler, controller):
            InViewControllerHelper.inView.createAlert(message: message, confirmHandler: confirmHandler, controller)
        }
    }
}

final class InViewService {
    
    @discardableResult
    func create(message: String, type: InViewControllerHelper.SubType, confirmHandler: ((Date) -> ())?, cancelHandler: (() -> ())?, dateHandler: ((Date) -> ())?, _ controller: UIViewController) -> CommonViewController {
        return createDatePicker(confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler, controller)
    }
    
    @discardableResult
    func createAlert(message: String, confirmHandler: (() -> ())?, _ controller: UIViewController) -> CommonViewController {
        return createCommonAlert(message: message, confirmHandler: confirmHandler, controller)
    }
    
    private func createCommonAlert(message: String, confirmHandler: (() -> ())?, _ controller: UIViewController) -> CommonViewController {
        let viewModel = AlertViewModel(message: message, confirmHandler: confirmHandler)
        let viewController = AlertViewController(with: viewModel)
        viewController.modalPresentationStyle = .custom
        controller.present(viewController, animated: true)
        return viewController
    }
    
    private func createDatePicker(confirmHandler: ((Date) -> ())?, cancelHandler: (() -> ())?, dateHandler: ((Date) -> ())?, _ controller: UIViewController) -> CommonViewController {
        let viewModel = CommonDatePickerViewModel(confirmHandler: confirmHandler, cancelHandler: cancelHandler, dateHandler: dateHandler)
        let inViewController = CommonDatePickerViewController(with: viewModel)
        inViewController.modalPresentationStyle = .custom
        controller.present(inViewController, animated: true)
        return inViewController
    }
}
