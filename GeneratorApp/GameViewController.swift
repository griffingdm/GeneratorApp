//
//  GameViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/11/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    @IBOutlet weak var spriteView: SKView!
    
    @IBOutlet weak var mamaView: UIView!
    @IBOutlet weak var lineStack: UIStackView!
    @IBOutlet weak var surgerOne: UIView!
    @IBOutlet weak var surgerTwo: UIView!
    @IBOutlet weak var surgerThree: UIView!
    @IBOutlet weak var surgerFour: UIView!
    @IBOutlet weak var surgerFive: UIView!
    @IBOutlet weak var surgesLabel: UILabel!
    
    @IBOutlet var theDots: [FullRoundView]!
    @IBOutlet var scoreIndicators: [FullRoundView]!
    @IBOutlet var cannons: [FullRoundView]!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoImageBackground: UIImageView!
    
    var surgers: [UIView]!
    var dotShots: [FullRoundView]!
    
    var scene:  GameScene!
    var skView: SKView!
    
    var win: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scene = GameScene(size: view.bounds.size)
        skView = spriteView as SKView
        
        skView.allowsTransparency = true
        scene.backgroundColor = UIColor.clear
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        scene.gameController = self
        
        surgers = [surgerOne, surgerTwo, surgerThree, surgerFour, surgerFive]
        
        for dot in theDots {
            dot.alpha = 0
        }
        
        surgesLabel.transform = surgesLabel.transform.rotated(by: toRadians(degrees: 270))
        view.layoutIfNeeded()
        
        //view.bringSubview(toFront: logoImageView)
        //animateCircuit()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateCircuit()
    }
    
    func animateCircuit(){
        logoImageBackground.layer.removeAllAnimations()
        
        logoImageBackground.alpha = 0
        
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.logoImageBackground.alpha = 1
        }){(finished: Bool) -> Void in
        }
    }
    
    func stopCircuit(){
        self.logoImageBackground.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.logoImageBackground.alpha = 0
        }){(finished: Bool) -> Void in
            self.logoImageBackground.layer.removeAllAnimations()
        }
    }
    
    @IBAction func gunDown(_ sender: UITapGestureRecognizer) {
        let gun: UITapGestureRecognizer = sender
        scene.shoot(tag:  (gun.view?.tag)!)
        
        if scene.view?.isPaused == false {
            for dot in theDots{
                if dot.tag == gun.view?.tag{
                    dot.alpha = 1
                    
                    UIView.animate(withDuration: 0.25, animations:{
                        dot.alpha = 0
                    })
                }
            }
            
            cannon()
        }
    }
    
    func toRadians(degrees: Double) -> CGFloat{
        return (CGFloat(degrees * M_PI) / 180.0)
    }
    
    func indicateScore(score: Int){
        for indicator in scoreIndicators {
            switch score {
            case 10:
                if indicator.tag == 0 {
                    foreverIndicate(theView: indicator)
                }
            case 20:
                if indicator.tag == 1 {
                    foreverIndicate(theView: indicator)
                }
            case 30:
                if indicator.tag == 2 {
                    foreverIndicate(theView: indicator)
                }
            case 40:
                if indicator.tag == 3 {
                    foreverIndicate(theView: indicator)
                }
            case 50:
                if indicator.tag == 4 {
                    foreverIndicate(theView: indicator)
                }
            case 100:
                allYellow()
            default:
                return
            }
        }
    }
    
    func foreverIndicate(theView: UIView){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            theView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
        }){(finished: Bool) -> Void in
        }
    }
    
    func allYellow(){
        for indicator in scoreIndicators{
            indicator.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                indicator.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
            }){(finished: Bool) -> Void in
            }
        }
    }
    
    func killIndicators(score: Int){
        let upperTag: Int = Int(floor(CGFloat(score)/10.0)) - 1
        
        for indicator in scoreIndicators {
            if indicator.tag <= upperTag {
                indicator.layer.removeAllAnimations()
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    indicator.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
                }){(finished: Bool) -> Void in
                    UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
                        indicator.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
                    }){(finished: Bool) -> Void in
                    }
                }
            }
        }
    }
    
    func flashSurger(surger: UIView){
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
            UIView.setAnimationRepeatCount(15)
            surger.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
        }){(finished: Bool) -> Void in
        }
        
        stopCircuit()
    }
    
    func returnSurger(rSurger: UIView){
        rSurger.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5, animations: {
            rSurger.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
        }){(finished: Bool) -> Void in
            UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
                rSurger.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
            }){(finished: Bool) -> Void in
            }
        }
    }
    
    func flashShooter(theDotTag: Int){
        for dot in theDots {
            if dot.tag == theDotTag{
                dot.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
                UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
                    UIView.setAnimationRepeatCount(15)
                    dot.alpha = 1
                }){(finished: Bool) -> Void in
                }
            }
        }
        
        stopCircuit()
    }
    
    func cannon(){
        for cannon in cannons {
            cannon.layer.removeAllAnimations()
            
            let delayAmount = Double(cannon.tag) / 20.0
            
            UIView.animate(withDuration: 0, delay: delayAmount, options: [], animations: {
                cannon.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
            }){(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    cannon.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
                }){(finished: Bool) -> Void in
                }
            }
        }
    }
    
    func returnShooter(theDotTag: Int){
        for dot in theDots {
            if dot.tag == theDotTag{
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    dot.alpha = 1
                    dot.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.2588235294, blue: 0.1450980392, alpha: 1)
                }){(finished: Bool) -> Void in
                    UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
                        dot.alpha = 0
                    }){(finished: Bool) -> Void in
                        dot.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLogo(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion:{
        })
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destController = segue.destination as! GameEndViewController
        
        // Pass the selected object to the new view controller.
        destController.gameController = self
        destController.score = scene.surgesCountered
        
        if win == true {
            destController.resultString = "You've Won!"
        } else {
            destController.resultString = "SYSTEM OVERLOAD!"
        }
    }
    
}
