//
//  DataTableViewCell.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    var dataModel: Rows? {
        didSet {
            dataImageView.image = UIImage(named: dataModel?.imageHref ?? "demo")
            titleLabel.text = dataModel?.title
            dataDescriptionLabel.text = dataModel?.description
        }
    }
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let dataDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    internal let dataImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "demo"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dataImageView)
        addSubview(titleLabel)
        addSubview(dataDescriptionLabel)
        
        dataImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: titleLabel.leftAnchor, paddingTop: 5,
                             paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 90, height: 0, enableInsets: false)
        titleLabel.anchor(top: topAnchor, left: dataImageView.rightAnchor, bottom: dataDescriptionLabel.topAnchor, right: rightAnchor, paddingTop: 20,
        paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: frame.size.width / 2, height: 0, enableInsets: false)
        dataDescriptionLabel.anchor(top: titleLabel.bottomAnchor, left: dataImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0,
                                    paddingLeft: 10, paddingBottom: 5, paddingRight: 5, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
