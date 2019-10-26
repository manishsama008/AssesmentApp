//
//  ImageCollectionViewCell.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 7.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func startAnimation() {
        DispatchQueue.main.async {
            for animateView in self.contentView.subviews {
                animateView.clipsToBounds = true
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.withAlphaComponent(0.2).cgColor, UIColor.clear.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
                gradientLayer.frame = animateView.bounds
                animateView.layer.mask = gradientLayer
                
                let animation = CABasicAnimation(keyPath: "transform.translation.x")
                animation.duration = 1.2
                animation.fromValue = -animateView.frame.size.width
                animation.toValue = animateView.frame.size.width
                animation.repeatCount = .infinity
                
                gradientLayer.add(animation, forKey: "")
            }
        }

    }
    
    func stopAnimation() {
        DispatchQueue.main.async {
            for animateView in self.contentView.subviews {
                animateView.layer.removeAllAnimations()
                animateView.layer.mask = nil
            }

        }
    }

}
