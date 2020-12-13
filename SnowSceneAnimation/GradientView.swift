//
//  GradientView.swift
//  SnowSceneAnimation
//
//  Created by Michael Haviv on 12/10/20.
//

import UIKit

class GradientView: UIView {

    var startColor: UIColor = UIColor.white
    var endColor: UIColor = UIColor.white
    
    // In order for this to act fully as a gradient layer, we need to override the layerClass property for the view. This returns CALayer by default, but we need it to return CAGradientLayer instead
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    // even though we made layerClass return a gradient layer, Swift will still think layer is a regular CALayer – we need to do a typecast before we can adjust its colors.
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [startColor.cgColor, endColor.cgColor]
    }

}
