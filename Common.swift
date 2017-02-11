//
//  Common.swift
//  test
//
//  Created by Timothy Lee on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
import CoreData
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

func fullCorners(view: UIView){
    view.layer.masksToBounds = true
    view.layer.cornerRadius = view.frame.height / 2
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

func toRadians(degrees: Double) -> CGFloat{
    return (CGFloat(degrees * M_PI) / 180.0)
}

func hasVotedUp(votes: [NSManagedObject], objId: String) -> Bool {
    var votedUp = false
    
    if votes != nil {
        for vote in votes {
            let id = vote.value(forKey: "id") as! String
            let up = vote.value(forKey: "up") as! Bool
            
            if objId == id && up {
                votedUp = true
            } else {
            }
        }
    } else {
        print("no votes")
    }
    
    return votedUp
}

func hasVotedDown(votes: [NSManagedObject], objId: String) -> Bool {
    var votedUp = false
    
    if votes != nil {
        for vote in votes {
            let id = vote.value(forKey: "id") as! String
            let up = vote.value(forKey: "up") as! Bool
            
            if objId == id && !up {
                votedUp = true
            } else {
            }
        }
    } else {
        print("no votes")
    }
    
    return votedUp
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, completion: @escaping() -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                completion()
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, completion: @escaping() -> Void) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
        downloadedFrom(url: url, completion:{
            completion()
        })
    }
    
}

