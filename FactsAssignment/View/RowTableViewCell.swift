//
//  DataTableViewCell.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit
import SDWebImage

/// Cell class to load in rows in facts tableview.
class RowTableViewCell: UITableViewCell {
    
    // MARK: UIControls
    
    /// Title of fact.
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    /// Description about fact.
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    /// Image of the fact.
    private let rowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: Variables
    
    /// object of rows model class.
    var rowModel: Rows? {
        didSet {
            self.titleLabel.text = rowModel?.title
            self.descriptionLabel.text = rowModel?.description
            
            guard let imageURL = rowModel?.imageHref, !imageURL.isEmpty else { self.rowImageView.image = nil
                return
            }
            // Image downloading and caching.
            self.rowImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"),
                                          options: .transformAnimatedImage,
                                          completed: { (_, error, _, _) in
                                            if error != nil {
                                                self.rowImageView.image = UIImage(named: "imageNotFound")
                                            }
            })
        }
    }
    
    // MARK: Initializers
    
    /**
     Initializer to setup contols in cell.
     
     - Parameters:
        - style: Style to set for cell
        - reuseIdentifier: `String` identifier to load cell.
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.addSubview(self.rowImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        
        self.titleLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: self.rowImageView.topAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingLeft: 0,
            paddingBottom: 5,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: true
        )
        
        self.rowImageView.anchor(
            top: self.titleLabel.bottomAnchor,
            left: leftAnchor,
            bottom: self.descriptionLabel.topAnchor,
            right: rightAnchor,
            paddingTop: 5,
            paddingLeft: 0,
            paddingBottom: 5,
            paddingRight: 0,
            width: 0,
            height: 0,
            enableInsets: true
        )
        
        self.descriptionLabel.anchor(
            top: self.rowImageView.bottomAnchor,
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
    
    /// Failable initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
