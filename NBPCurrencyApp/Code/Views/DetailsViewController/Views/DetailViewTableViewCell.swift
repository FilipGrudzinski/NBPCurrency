//
//  DetailViewTableViewCell.swift
//  NBPCurrencyApp
//
//  Created by Filip Grudziński on 12/03/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class DetailViewTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 4.0
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 4.0
        static let shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var codeView: UIView!
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var averageLabel: UILabel!
    @IBOutlet private weak var averageValueLabel: UILabel!
    @IBOutlet private weak var publicationTitleLabel: UILabel!
    @IBOutlet private weak var publicationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
        averageValueLabel.textAlignment = .right
        publicationDateLabel.textAlignment = .right
        backgroundColor = .white
        currencyLabel.textColor = .black
        averageLabel.textColor = .black
        averageValueLabel.textColor = .black
        publicationTitleLabel.textColor = .black
        publicationDateLabel.textColor = .black
        publicationTitleLabel.textAlignment = .right
        publicationDateLabel.textAlignment = .right
        averageValueLabel.font = .font(with: .regular, size: .medium)
        averageLabel.font = .font(with: .regular, size: .medium)
        
        publicationTitleLabel.font = .font(with: .regular, size: .small)
        publicationDateLabel.font = .font(with: .regular, size: .small)
        codeLabel.textAlignment = .center
        codeView.backgroundColor = .appPurple
        codeView.layer.masksToBounds = true
        codeView.layer.cornerRadius = Constants.cornerRadius
        codeLabel.textColor = .white
        setupCommonText()
        
        setupShadow()
    }
    
    private func setupCommonText() {
        averageLabel.text = Localized.averageText
        publicationTitleLabel.text = Localized.publicationTitle
    }
    
    private func setupShadow() {
        shadowView.layer.cornerRadius = Constants.cornerRadius
        shadowView.layer.shadowColor = UIColor.appPastel.cgColor
        shadowView.layer.shadowOpacity = Constants.shadowOpacity
        shadowView.layer.shadowRadius = Constants.shadowRadius
        shadowView.layer.shadowOffset = Constants.shadowOffset
    }
    
    func setupData(_ model: DetailViewDataSourceItem) {
        currencyLabel.text = model.title
        codeLabel.text = model.code
        publicationDateLabel.text = model.effectiveDate
        
        switch model.table {
        case TablesType.a.title:
            averageValueLabel.text = String(format: .threDecimalPlacesFormat, model.mid ?? .zero)
        case TablesType.b.title:
            guard let mid = model.mid else {
                return
            }
            let midToshow = mid * Double(Digit.hundred)
            averageValueLabel.text = String(format: .threDecimalPlacesFormat, midToshow)
        case TablesType.c.title:
            averageValueLabel.isHidden = model.mid == nil
            averageLabel.isHidden = model.mid == nil
        default: ()
        }
    }
}
