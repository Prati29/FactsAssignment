//
//  DataTableViewCell.swift
//  FactsAssignment
//
//  Created by Savita Pal on 09/07/20.
//  Copyright © 2020 Pratiksha. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

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
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20.0)
            make.left.equalTo(self.snp.left).offset(0.0)
            make.right.equalTo(self.snp.right).offset(0.0)
            make.bottom.equalTo(self.rowImageView.snp.top).offset(-10.0)
        }

        self.rowImageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5.0)
            make.left.equalTo(self.snp.left).offset(0.0)
            make.right.equalTo(self.snp.right).offset(0.0)
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-10.0)
        }

        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.rowImageView.snp.bottom).offset(5.0)
            make.left.equalTo(self.snp.left).offset(0.0)
            make.right.equalTo(self.snp.right).offset(0.0)
            make.bottom.equalTo(self.snp.bottom).offset(-10.0)
        }
    }
    
    /// Failable initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
