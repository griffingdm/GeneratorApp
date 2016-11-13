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
    
    @IBOutlet weak var dotShot: FullRoundView!
    @IBOutlet weak var dotShotTwo: FullRoundView!
    @IBOutlet weak var dotShotthree: FullRoundView!
    @IBOutlet weak var dotShotFour: FullRoundView!
    @IBOutlet weak var dotShotFive: FullRoundView!
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    
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
        
        dotShots = [dotShot, dotShotTwo, dotShotthree, dotShotFour, dotShotFive]
        
        for dot in dotShots {
            dot.alpha = 0
        }
        
        //view.bringSubview(toFront: logoImageView)
    }
    
    @IBAction func gunDown(_ sender: UITapGestureRecognizer) {
        let gun: UITapGestureRecognizer = sender
        scene.shoot(tag:  (gun.view?.tag)!)
        
        var theDot = dotShots[(gun.view?.tag)!]
        theDot.alpha = 1
        UIView.animate(withDuration: 0.25, animations:{
            theDot.alpha = 0
        })
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
            destController.resultString = "It overloaded! Try Again."
        }
    }
    
}
