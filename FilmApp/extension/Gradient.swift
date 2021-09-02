//
//  Gradient.swift
//  FilmApp
//
//  Created by Клим on 01.09.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func applyGradient() {
        let topColor: UIColor = UIColor(white: 0, alpha: 0)
        let bottomColor: UIColor = .black
        
        let startPointX: CGFloat = 0
        let startPointY: CGFloat = 0.5
        let endPointX: CGFloat = 0
        let endPointY: CGFloat = 1
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
