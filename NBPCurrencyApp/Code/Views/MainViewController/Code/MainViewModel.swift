//
//  MainViewModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 11/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate! { get set }
    var title: String { get }
    var dataSourceCount: Int { get }
    
    func onViewDidLoad()
    func didTapSegment(_ index: Int)
    func item(at indexPath: IndexPath) -> MainViewDataSourceItem
    func didTapCell(at indexPath: IndexPath)
    func refreshData(_ index: Int)
}

protocol MainViewModelDelegate: class {
    func setSegment(_ index: Int)
    func reloadData()
    func setSegmentControlData(data: [TablesType])
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: CommonWorkerProtocol
    private let parser: JsonParserWorkerProtocol
    private var itemDataSource: [MainViewDataSourceItem] = []
    private var segmentDataSource: [TablesType] = []
    
    init(worker: CommonWorkerProtocol = CommonWorker(), parser: JsonParserWorkerProtocol = JsonParserWorker(),  coordinator: MainCoordinatorProtocol) {
        self.worker = worker
        self.parser = parser
        self.coordinator = coordinator
    }
    
    private func prepareTableViewItem(_ data: TableResponseModel) {
        itemDataSource.removeAll()
        data.rates.forEach {
            itemDataSource.append(MainViewDataSourceItem(table: data.table,
                                                         title: $0.currency,
                                                         code: $0.code,
                                                         mid: $0.mid,
                                                         bid: String(describing: $0.bid),
                                                         ask: String(describing: $0.ask),
                                                         effectiveDate: data.effectiveDate))
        }
        
        delegate.reloadData()
    }
    
    private func fetchData(_ type: TablesType) {
        worker.getTablesData(type.title)
            .done { response in
                self.prepareTableViewItem(self.parser.parseTablesJsonData(response))
        }
        .catch { error in
            print(error.localizedDescription) }
    }
}

extension MainViewModel: MainViewModelProtocol {
    var title: String { Localized.mainViewTitle }
    var dataSourceCount: Int { itemDataSource.count }
    
    func onViewDidLoad() {
        TablesType.allCases.forEach { segmentDataSource.append($0) }
        delegate.setSegmentControlData(data: segmentDataSource)
        fetchData(segmentDataSource[.zero])
        delegate.setSegment(.zero)
    }
    
    func didTapSegment(_ index: Int) {
        fetchData(segmentDataSource[index])
    }
    
    func item(at indexPath: IndexPath) -> MainViewDataSourceItem {
        return itemDataSource[indexPath.row]
    }
    
    func didTapCell(at indexPath: IndexPath) {
        let itemTap = item(at: indexPath)
        let itemToSend = DetailItemModel(currency: itemTap.title, table: itemTap.table, code: itemTap.code)
        coordinator.showDetailView(itemModel: itemToSend)
    }
    
    func refreshData(_ index: Int) {
        fetchData(segmentDataSource[index])
    }
}
