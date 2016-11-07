//
//  LaunchTransition.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/6/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class LaunchTransition: BaseTransition {
    var newLogo: UIImageView!
    
    //spring animation settings
    let springDamp: CGFloat! = 0.8
    let springVel: CGFloat! = 6
    
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let fromController = fromViewController as! LaunchSplashViewController
        let toController = toViewController as! LoginViewController
        toController.view.layoutIfNeeded()
        let fromImage = fromController.logoImageView!
        let toImage = toController.logoImageView!
        
        newLogo = UIImageView()
        newLogo.frame = containerView.convert(fromImage.frame, from: fromImage.superview)
        newLogo.image = fromImage.image
        newLogo.contentMode = fromImage.contentMode
        
        containerView.addSubview(newLogo)
        fromController.logoImageView.alpha = 0
        toController.logoImageView.alpha = 0
        toViewController.view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.newLogo.frame = containerView.convert(toImage.frame, from: toImage.superview)
        }, completion: { (Bool) in
            toController.logoImageView.alpha = 1
            self.newLogo.removeFromSuperview()
            self.finish()
        })
        
//        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamp, initialSpringVelocity: springVel, options: [], animations: {
//            self.newLogo.frame = containerView.convert(toImage.frame, from: toImage.superview)
//        }) { (Bool) in
//            toController.logoImageView.alpha = 1
//            self.newLogo.removeFromSuperview()
//            self.finish()
//        }
        
        UIView.animate(withDuration: duration/2, delay: duration/2, options: [], animations: {
            toViewController.view.alpha = 1
        }) { (Bool) in
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
