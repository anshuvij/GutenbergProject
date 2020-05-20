//
//  CollectionViewCell.swift
//  Gutenberg Project
//
//  Created by Anshu Vij on 5/19/20.
//  Copyright © 2020 Anshu Vij. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.cornerRadius = 8
        self.mainView.layer.cornerRadius = 8
        self.mainView.clipsToBounds = true
      
    }

}
