//
//  ShapeView.swift
//  SnowSceneAnimation
//
//  Created by Michael Haviv on 12/11/20.
//

import UIKit

class ShapeView: UIView {
    
    var strokeWidth: CGFloat = 2.0
    var strokeColor: UIColor = UIColor.black
    var fillColor: UIColor = UIColor.clear
    var path: UIBezierPath?

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    // we’re going to have users specify their paths in normalized coordinates, where X:0 is the left edge of their path and X:1 is the right edge, and Y:0 is the top and Y:1 the bottom. We can then write code to scale up the path by the size of our view, so that it always fits the available space.
    // to make the snow scene look just a little nicer, we’re going to draw on the ability of CAShapeLayer to render shadows. Here, though, we’re going to make the “shadow” the same as our stroke color so that it acts as a glow instead, giving the snow a slightly hazy look.
    override func layoutSubviews() {
        let layer = self.layer as! CAShapeLayer

        // take a copy of our original path, because we're about to stretch it
        guard let pathCopy = path?.copy() as? UIBezierPath else { return }

        // create a transform that stretches the path by our width and height, and apply it to the copy
        pathCopy.apply(CGAffineTransform(scaleX: bounds.width, y: bounds.height))

        // apply all our properties to the shape layer
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineWidth = strokeWidth
        layer.shadowColor = strokeColor.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1

        // convert the UIBezierPath to a CGPath and use it for the shape path
        layer.path = pathCopy.cgPath
    }

}
