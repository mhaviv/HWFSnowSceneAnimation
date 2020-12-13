//
//  SnowAnimationVC.swift
//  SnowSceneAnimation
//
//  Created by Michael Haviv on 12/10/20.
//

import UIKit

class SnowAnimationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSkyBackground()
        configureSnowParticles()
        configureGround()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    func configureSkyBackground () {
        let sky = GradientView()
        sky.startColor = UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1)
        sky.endColor = UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1)
        sky.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sky)

        NSLayoutConstraint.activate([
            sky.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sky.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sky.topAnchor.constraint(equalTo: view.topAnchor),
            sky.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureSnowParticles() {
        let snow = ParticleView()
        snow.particleImage = UIImage(named: "snow-particle")
        snow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snow)
        
        NSLayoutConstraint.activate([
            snow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            snow.topAnchor.constraint(equalTo: view.topAnchor),
            snow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureGround() {
        let ground = ShapeView()
        ground.path = makeGround()
        ground.strokeColor = .white
        ground.fillColor = .white
        ground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ground)
        
        NSLayoutConstraint.activate([
            ground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    // Creating a Bezier path takes some effort: either you type values in by hand because you’re a mathematics prodigy, you type values in by hand then monkey with them for 20 minutes using trial and error because you’re a mere mortal, or you use something like PaintCode because you realize that paying a small amount of money to buy a code-generating tool pays for itself in only a few days.
    
    // I used PaintCode to draw a simple rectangle with some very gentle curves along the top, and it generated the full UIBezierPath code in Swift for me – nice!
    
    func makeGround() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0.77))
        bezierPath.addLine(to: CGPoint(x: 0, y: 1.0))
        bezierPath.addLine(to: CGPoint(x: 1.0, y: 1.0))
        bezierPath.addLine(to: CGPoint(x: 1.0, y: 0.08))
        bezierPath.addCurve(to: CGPoint(x: 0.80, y: 0.08), controlPoint1: CGPoint(x: 1.0, y: 0.08), controlPoint2: CGPoint(x: 0.91, y: 0.02))
        bezierPath.addCurve(to: CGPoint(x: 0.55, y: 0.02), controlPoint1: CGPoint(x: 0.69, y: 0.13), controlPoint2: CGPoint(x: 0.56, y: 0.02))
        bezierPath.addCurve(to: CGPoint(x: 0.34, y: 0.02), controlPoint1: CGPoint(x: 0.54, y: 0.02), controlPoint2: CGPoint(x: 0.44, y: -0.03))
        bezierPath.addCurve(to: CGPoint(x: 0.112, y: 0.024), controlPoint1: CGPoint(x: 0.25, y: 0.08), controlPoint2: CGPoint(x: 0.20, y: -0.03))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 0.08), controlPoint1: CGPoint(x: 0.02, y: 0.08), controlPoint2: CGPoint(x: 0, y: 0.08))

        return bezierPath
    }

}
