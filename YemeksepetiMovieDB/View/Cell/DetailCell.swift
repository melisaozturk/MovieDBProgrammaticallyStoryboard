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
        labelText.numberOfLines = 0
    }
    
    private func configureConstraints() {

        addSubview(labelText)
        addSubview(labelValue)
        
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        labelValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        labelValue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.topAnchor.constraint(equalTo: labelValue.topAnchor).isActive = true
        labelText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        labelText.trailingAnchor.constraint(equalTo: labelValue.leadingAnchor).isActive = true
        labelText.bottomAnchor.constraint(equalTo: labelValue.bottomAnchor).isActive = true
    }
    
}
