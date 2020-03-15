//
//  MainCoordinator.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func showDetailView(itemModel: DetailItemModel)
}

final class MainCoordinator: MainCoordinatorProtocol {

    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private let navigationController = MainNavigationController()

    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        parentCoordinator.showRootViewController(rootViewController: navigationController)
    }
    
    func showDetailView(itemModel: DetailItemModel) {
        let viewModel = DetailViewModel(itemModel: itemModel, coordinator: self)
        let viewController = DetailViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
