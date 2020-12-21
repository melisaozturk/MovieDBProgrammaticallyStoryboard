//
//  DetailCell.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 21.12.2020.
//

import UIKit
import Kingfisher

class DetailCell: UITableViewCell {
    
    private var labelText = UILabel()
    private var labelValue = UILabel()
    
    lazy var stackViewContainer: UIStackView = {
        var stackViewContainer = UIStackView()
        stackViewContainer.axis = .vertical
        stackViewContainer.alignment = .leading
        stackViewContainer.distribution = .fillProportionally
        stackViewContainer.spacing = 10
        stackViewContainer.contentMode = .scaleToFill
        return stackViewContainer
    }()
    
    var cellResultModel: LabelModel? {
        didSet {
            labelText.text = cellResultModel!.text
            labelValue.text = cellResultModel!.value
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        labelValue.numberOfLines = 0
        labelValue.adjustsFontSizeToFitWidth = true
        
        labelText.numberOfLines = 0
        labelText.adjustsFontSizeToFitWidth = true
    }
    
    private func configureConstraints() {
        addSubview(stackViewContainer)

        stackViewContainer.addArrangedSubview(labelText)
        stackViewContainer.addArrangedSubview(labelValue)
        
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true

    }
    
}
