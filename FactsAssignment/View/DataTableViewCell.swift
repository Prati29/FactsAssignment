//
//  DataTableViewCell.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit
import SDWebImage

class DataTableViewCell: UITableViewCell {
    var factModel: Rows? {
        didSet {
            titleLabel.text = factModel?.title
            dataDescriptionLabel.text = factModel?.description
            guard let imageURL = factModel?.imageHref, !imageURL.isEmpty else { self.dataImageView.image = nil
                return
            }
            dataImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"),
                                      options: .transformAnimatedImage,
                                      completed: { (_, error, _, _) in
                                        if error != nil {
                                            self.dataImageView.image = UIImage(named: "imageNotFound")
                                        }
            })
        }
    }
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    private let dataImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "loading"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addSubview(dataImageView)
        addSubview(titleLabel)
        addSubview(dataDescriptionLabel)
        
        titleLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: dataImageView.topAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingLeft: 0,
            paddingBottom: 5,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: true
        )
        
        dataImageView.anchor(
            top: titleLabel.bottomAnchor,
            left: leftAnchor,
            bottom: dataDescriptionLabel.topAnchor,
            right: rightAnchor,
            paddingTop: 5,
            paddingLeft: 0,
            paddingBottom: 5,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: true
        )
        
        dataDescriptionLabel.anchor(
            top: dataImageView.bottomAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 5,
            paddingLeft: 0,
            paddingBottom: 10,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: true
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
