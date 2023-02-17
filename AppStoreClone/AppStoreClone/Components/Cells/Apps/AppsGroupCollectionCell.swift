//
//  AppsGroupCollectionCell.swift
//  AppStoreClone
//
//  Created by Umut Can Arslan on 4.02.2023.
//

import UIKit

class AppsGroupCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "SearchResultCollectionCell"
    
    let appsHorizontalController = AppsHorizontalViewController()
    let sectionLabel = UILabel(font: .boldSystemFont(ofSize: 28))
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayutSectionLabel()
        autoLayoutAppsHorizontalController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Helpers
    fileprivate func autoLayutSectionLabel() {
        addSubview(sectionLabel)
        sectionLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing:trailingAnchor,
            padding: .init(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        )
    }
    
    fileprivate func autoLayoutAppsHorizontalController() {
        addSubview(appsHorizontalController.view)
        appsHorizontalController.view.anchor(
            top: sectionLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor
        )
    }
    
    func configure(with model: AppGroup) {
        self.sectionLabel.text = model.feed?.title ?? "-"
        appsHorizontalController.configure(with: model.feed?.results ?? [])
    }
    
}
