//
//  ParticleView.swift
//  SnowSceneAnimation
//
//  Created by Michael Haviv on 12/10/20.
//

// we need to add a snow effect. This is where CAEmitterLayer comes in, because it’s specifically designed to create and manipulate particles such as fire, smoke, fog, rain, and snow.

// We’re going to create a reusable ParticleView class here, that generates particles at three levels: near, middle, and far. This is done by using the same particle three times, while varying the speed, scale, and alpha to create a depth effect

import UIKit

class ParticleView: UIView {

    var particleImage: UIImage?

    // We need to override the same layerClass property as with GradientView, except now we’ll be making it return an emitter layer instead
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    // write a makeEmitterCell method that takes three parameters: the color to use for the snowflake (varying transparencies of white), how fast it’s falling, and how big it is
    /*
     The birthRate will be 10, which means it will create 10 snowflakes a second
     The lifetime will be 20, so each snowflake exists for 20 seconds.
     The color and velocity will be set to whatever we passed in.
     The velocityRange – how much individual flakes can be faster or slower than the standard velocity will be one quarter of whatever velocity we passed in.
     The emissionLongitude – which direction particles are created in – will be .pi, meaning “straight down.”
     The emissionRange – how much variation in direction we allow – will be .pi / 8, which is about 20 degrees.
     The scale will be whatever we passed in, and scaleRange – how much to vary the size of the flakes – will be one third of the scale.
     The contents of the cell – which image it shows – will be the particle image from our emitter view.
     */
    
    func makeEmitterCell(color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 20.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = scale
        cell.scaleRange = scale / 3

        cell.contents = particleImage?.cgImage
        return cell
    }
    
    override func layoutSubviews() {
        let emitter = self.layer as! CAEmitterLayer

        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)

        let near = makeEmitterCell(color: UIColor(white: 1, alpha: 1), velocity: 100, scale: 0.3)
        let middle = makeEmitterCell(color: UIColor(white: 1, alpha: 0.66), velocity: 80, scale: 0.2)
        let far = makeEmitterCell(color: UIColor(white: 1, alpha: 0.33), velocity: 60, scale: 0.1)

        emitter.emitterCells = [near, middle, far]
    }

}
