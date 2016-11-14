//
//  GameEndViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/12/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class GameEndViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var resultString: String! = ""
    var score: Int = 0
    
    var gameController: GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultLabel.text = resultString
        scoreLabel.text = "\(score) SURGES"
        
        saveScore(theScore: score)
    }
    
    func saveScore(theScore: Int){
        let gameScore = PFObject(className:"GameScore")
        gameScore["score"] = score
        switch appDelegate.user {
        case nil:
            print("anonymous user")
            gameScore["playerName"] = "-"
        default:
            gameScore["playerName"] = appDelegate.user
        }

        gameScore.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
                print("saved!")
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressGiveUp(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: {})
        
    }
    
    @IBAction func pressRestart(_ sender: Any) {
        dismiss(animated: true, completion:{
            self.gameController.surgesLabel.text = "PREPARE!"
            self.gameController.animateCircuit()
            self.gameController.scene.gameStart()
        })
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
