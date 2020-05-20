//
//  CustomButton.swift
//  Gutenberg Project
//
//  Created by Anshu Vij on 5/19/20.
//  Copyright © 2020 Anshu Vij. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable var leftHandImage: UIImage? {
        didSet {
            leftHandImage = leftHandImage?.withRenderingMode(.alwaysOriginal)
            setupImages()
        }
    }
    @IBInspectable var rightHandImage: UIImage? {
        didSet {
            rightHandImage = rightHandImage?.withRenderingMode(.alwaysOriginal)
            setupImages()
        }
    }

    func setupImages() {
        if let leftImage = leftHandImage {
            self.setImage(leftImage, for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.imageView?.frame = CGRect(x: 10, y: self.frame.width-10, width: 5, height: 5)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: self.frame.width - (self.imageView?.frame.width)!)
        }

        if let rightImage = rightHandImage {
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.tintColor = UIColor.blue
            rightImageView.contentMode = .scaleAspectFit
        
            let xPos = self.frame.width - 60
            let yPos = (self.frame.height - 30) / 2

            rightImageView.frame = CGRect(x: xPos, y: yPos, width: 25, height: 25)
            self.addSubview(rightImageView)
        }
    }
}

