//
//  DetailViewModel.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 14/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

enum TextFieldType: Int, CaseIterable {
    case start
    case end
}

protocol DetailViewModelProtocol: class {
    var delegate: DetailViewModelDelegate! { get set }
    var searchButtonText: String { get }
    var title: String { get }
    var startDateText: String { get }
    var endDateText: String { get }
    var dataSourceCount: Int { get }
    
    func onViewDidLoad()
    func refreshData()
    func textDidChangeClosure(text: String, index: Int)
    func item(at indexPath: IndexPath) -> DetailViewDataSourceItem
    func updateDatePickerHandler(date: Date)
    func selectTextFieldPick(index: Int)
    func searchDateData()
    func clearData()
}

protocol DetailViewModelDelegate: class {
    func updateTextField(text: String, selected: Int)
    func reloadData()
    func presentAlert(message: String)
}

final class DetailViewModel {
    weak var delegate: DetailViewModelDelegate!
    private let dateFormatter = DateFormatter()
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: CommonWorkerProtocol
    private let parser: JsonParserWorkerProtocol
    private var itemDataSource: [DetailViewDataSourceItem] = []
    private let itemModel: DetailItemModel
    private var startDate: String = .empty
    private var endDate: String = .empty
    
    private var selectedTextField: TextFieldType = .start
    
    init(itemModel: DetailItemModel, worker: CommonWorkerProtocol = CommonWorker(), parser: JsonParserWorkerProtocol = JsonParserWorker(), coordinator: MainCoordinatorProtocol) {
        self.itemModel = itemModel
        self.worker = worker
        self.parser = parser
        self.coordinator = coordinator
    }
    
    private func prepareTableViewItem(_ data: TablesCodeResponseModel) {
        itemDataSource.removeAll()
        
        data.rates.forEach {
            itemDataSource.append(DetailViewDataSourceItem(table: data.table,
                                                           title: data.currency,
                                                           code: data.code,
                                                           mid: $0.mid,
                                                           bid: String(describing: $0.bid),
                                                           ask: String(describing: $0.ask), effectiveDate: $0.effectiveDate
            ))
        }
        delegate.reloadData()
    }
    
    private func fetchData() {
        worker.getTableCodeData(itemModel.table, itemModel.code)
            .done { response in
                self.prepareTableViewItem(self.parser.parseRatesCodeJsonData(response))
        }
        .catch { error in
            self.errorHandler(error: error)
        }
    }
    
    private func fetchDataWithDate() {
        worker.getDateRates(itemModel.table, itemModel.code, startDate, endDate)
            .done { response in
                self.prepareTableViewItem(self.parser.parseRatesCodeJsonData(response))
        }
        .catch { error in
            self.errorHandler(error: error)
        }
    }
    
    private func convertDateToString(_ date: Date) -> String {
        dateFormatter.dateFormat = .apiDateFormat
        let stringDate = dateFormatter.string(from: date)
        switch selectedTextField {
        case .start:
            startDate = stringDate
            return stringDate
        case .end:
            endDate = stringDate
            return stringDate
        }
    }
    
    private func errorHandler(error: Error) {
        guard let networkError = error as? APIError else {
            fatalError()
        }
        
        switch networkError {
        case .badRequest, .notFound:
            delegate.presentAlert(message: networkError.message)
        }
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    var title: String { itemModel.currency }
    var startDateText: String { Localized.startDateText }
    var endDateText: String { Localized.endDateText }
    var searchButtonText: String { Localized.searchButtonTitle }
    var dataSourceCount: Int { itemDataSource.count }
    
    func onViewDidLoad() {
        fetchData()
    }
    
    func refreshData() {
        guard startDate.isNotEmpty, endDateText.isNotEmpty else {
            fetchData()
            return
        }
        fetchDataWithDate()
    }
    
    func textDidChangeClosure(text: String, index: Int) {
        switch index {
        case TextFieldType.end.rawValue:
            startDate = text
        case TextFieldType.start.rawValue:
            endDate = text
        default: ()
        }
    }
    
    func item(at indexPath: IndexPath) -> DetailViewDataSourceItem {
        return itemDataSource[indexPath.row]
    }
    
    func selectTextFieldPick(index: Int) {
        switch index {
        case TextFieldType.end.rawValue:
            selectedTextField = .end
        case TextFieldType.start.rawValue:
            selectedTextField = .start
        default: ()
        }
    }
    
    func updateDatePickerHandler(date: Date) {
        #warning("Add later secondPicker max day or maybe unloc second textField when first with date")
        delegate.updateTextField(text: convertDateToString(date), selected: selectedTextField.rawValue)
    }
    
    func searchDateData() {
        #warning("Add later validation for moreOrUqual max api day")
        fetchDataWithDate()
    }
    
    func clearData() {
        endDate = .empty
        startDate = .empty
        delegate.updateTextField(text: .empty, selected: TextFieldType.start.rawValue)
        delegate.updateTextField(text: .empty, selected: TextFieldType.end.rawValue)
    }
}
