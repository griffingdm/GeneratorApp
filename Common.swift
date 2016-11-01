//
//  Common.swift
//  test
//
//  Created by Timothy Lee on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

func CGAffineTransformMakeDegreeRotation(_ rotation: CGFloat) -> CGAffineTransform {
    return CGAffineTransform(rotationAngle: rotation * CGFloat(M_PI / 180))
}

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func convertValue(_ value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
    let ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}

func tileBG(view: UIView, image: UIImage){
    view.backgroundColor = UIColor(patternImage: image)
}

func roundCorners(view: UIView, radius: CGFloat){
    view.layer.masksToBounds = true
    view.layer.cornerRadius = radius
}

func vertGradient(topColor: CGColor, bottomColor: CGColor, frame: CGRect, yStart: CGFloat) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x:0.5, y: yStart)
        gradientLayer.endPoint = CGPoint(x:0.5, y: 1)
        gradientLayer.frame = frame
        return gradientLayer
}
