//
//  GameScene.swift
//  GameTest
//
//  Created by Mullins, Griffin on 11/11/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Surge   : UInt32 = 0b1       // 1
    static let Counter: UInt32 = 0b10      // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameController: GameViewController!
    var surgesCountered: Int = 0
    var travelDuration = 3.0
    
    var birthTimer:TimeInterval = TimeInterval(0)
    var birthInterval:TimeInterval = TimeInterval(1)
    
    var delta:TimeInterval = TimeInterval(0)
    var last_update_time:TimeInterval = TimeInterval(0)
    
    let fadeTime: Double = 0.5
    
    override func didMove(to view: SKView) {
        //adding background music!
        //let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
        //backgroundMusic.autoplayLooped = true
        //addChild(backgroundMusic)
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        gameStart()
    }
    
    func gameStart(){
        removeAllChildren()
        
        surgesCountered = 0
        birthInterval = 1.0
        travelDuration = 3.0
        
        self.scene?.view?.isPaused = false
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        // Create sprite
        let surge = SKSpriteNode(imageNamed: "game-surge")
        
        surge.physicsBody = SKPhysicsBody(rectangleOf: surge.size)
        surge.physicsBody?.isDynamic = true
        surge.physicsBody?.categoryBitMask = PhysicsCategory.Surge
        surge.physicsBody?.contactTestBitMask = PhysicsCategory.Counter
        surge.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let rDistributer = GKRandomDistribution(forDieWithSideCount: 5)
        let rNumber = rDistributer.nextInt() - 1
        let rSurger = gameController.surgers[rNumber]
        let rSurgerFrame = rSurger.frame
        //let surgeRect = gameController.view.convert(rSurgerFrame, to: rSurger.superview)
        let surgeRect = gameController.spriteView.convert(rSurgerFrame, from: rSurger.superview)
        let actualX = (surgeRect.midX)
        
        //print("surger: \(rNumber), x: \(actualX)")
        
        surge.position = CGPoint(x: actualX, y: size.height + surge.size.height/2)
        
        // Add the surge to the scene
        addChild(surge)
        
        // Determine speed
        //let actualDuration = random(min: CGFloat(2.0), max: CGFloat(3.0))
        
        var dots: [FullRoundView]! = []
        for dot in self.gameController.theDots {
            if dot.tag == rNumber {
                dots.append(dot)
            }
        }
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: 0 - surge.size.height/2), duration: TimeInterval(travelDuration))
        let actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.run(){
            self.gameController.win = false
            self.scene?.view?.isPaused = true
            
            self.gameController.flashShooter(theDotTag: rNumber)
            self.gameController.killIndicators(score: self.surgesCountered)
            
            delay(2.0, closure: {
                self.gameController.performSegue(withIdentifier: "gameEndSegue", sender: nil)
                self.gameController.returnShooter(theDotTag: rNumber)
            })
            //self.view?.presentScene(nil)
        }
        surge.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if self.last_update_time == 0.0 {
            self.delta = 0
        } else {
            self.delta = currentTime - self.last_update_time
        }
        
        self.birthTimer += self.delta
        
        if self.birthTimer >= birthInterval {
            run(SKAction.sequence([
                SKAction.run(addMonster)
                ])
            )
            
            if birthInterval > 0.35 {
                self.birthInterval -= 0.025
            }
            self.birthTimer = 0
        }
        
        self.last_update_time = currentTime
        //self.yourSprite.update(self.delta)
    }
    
    func shoot(tag: Int){
        //run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        
        let counter = SKSpriteNode(imageNamed: "game-current-counter")
        
        counter.physicsBody = SKPhysicsBody(rectangleOf: counter.size)
        counter.physicsBody?.isDynamic = true
        counter.physicsBody?.categoryBitMask = PhysicsCategory.Counter
        counter.physicsBody?.contactTestBitMask = PhysicsCategory.Surge
        counter.physicsBody?.collisionBitMask = PhysicsCategory.None
        counter.physicsBody?.usesPreciseCollisionDetection = true
        
        let rSurger = gameController.surgers[tag]
        let rSurgerFrame = rSurger.frame
        //let surgeRect = gameController.view.convert(rSurgerFrame, to: rSurger.superview)
        let surgeRect = gameController.spriteView.convert(rSurgerFrame, from: rSurger.superview)
        let actualX = (surgeRect.midX)
        
        counter.position = CGPoint(x: actualX, y: 0 - counter.size.height/2)
        
        addChild(counter)
        
        let actualDuration = 1.0
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: size.height + counter.size.height/2), duration: actualDuration)
        let actionMoveDone = SKAction.removeFromParent()
        let loseAction = SKAction.run(){
            self.gameController.win = false
            self.scene?.view?.isPaused = true
            
            self.gameController.flashSurger(surger: rSurger)
            self.gameController.killIndicators(score: self.surgesCountered)
            
            delay(2.0, closure: {
                self.gameController.performSegue(withIdentifier: "gameEndSegue", sender: nil)
                self.gameController.returnSurger(rSurger: rSurger)
            })
        }
        counter.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    
    func didCounterSurge(surge: SKSpriteNode, counter: SKSpriteNode){
        print("countered!")
        surge.removeFromParent()
        counter.removeFromParent()
        
        surgesCountered += 1
        
        if travelDuration > 0.4 {
            travelDuration -= 0.025
        }
        
        gameController.surgesLabel.text = "SURGES: \(surgesCountered)"
        gameController.indicateScore(score: surgesCountered)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Surge != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Counter != 0)) {
            didCounterSurge(surge: firstBody.node as! SKSpriteNode, counter: secondBody.node as! SKSpriteNode)
        }
    }
}
