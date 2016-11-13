//
//  GameEndViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/12/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class GameEndViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var resultString: String! = ""
    var score: Int = 0
    
    var gameController: GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultLabel.text = resultString
        scoreLabel.text = "\(score) SURGES"
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
