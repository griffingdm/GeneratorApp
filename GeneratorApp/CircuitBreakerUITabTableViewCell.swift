//
//  CircuitBreakerUITabTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/13/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class CircuitBreakerUITabTableViewCell: UITableViewCell {
    @IBOutlet weak var circuitBreakImageView: UIImageView!
    @IBOutlet weak var CircuitBreakLabel: SpaceLabel!
    @IBOutlet weak var topThreeStack: UIStackView!
    
    @IBOutlet var topPlayerLabels: [SpaceLabel]!
    @IBOutlet var topScoreLabels: [SpaceLabel]!
    
    var parentController: PrincipalViewController!
    
    var gameScores: [GameScore]! = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func playCircuitBreaker(_ sender: Any) {
        parentController.tabViewController.performSegue(withIdentifier: "gameSegue", sender: nil)
    }
    
    func getTheScores() {
        if gameScores.count == 0 {
            topThreeStack.isHidden = true
            
            let query = PFQuery(className:"GameScore")
            query.order(byDescending: "score")
            query.limit = 3
            
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if error == nil {
                    
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                            print(object.objectId ?? "-")
                            let thisName = object["playerName"] as! String
                            let thisScore = object["score"] as! Int
                            
                            let newGameScore = GameScore(playerName: thisName, score: thisScore)
                            
                            //print(object["playerName"])
                            
                            self.gameScores.append(newGameScore)
                        }
                        
                        self.setTheScores()
                        //self.activityIndicator.stopAnimating()
                        //self.activityIndicator.superview?.alpha = 0
                        //self.scoreTableView.reloadData()
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!)")
                    print("THAT DIDNT WORK")
                }
            }
        }
    }
    
    func setTheScores(){
        if gameScores.count > 0 {
            for (index, pLabel) in topPlayerLabels.enumerated(){
                if gameScores[index].playerName != nil {
                    pLabel.text = gameScores[index].playerName!
                }
            }
            
            for (index, sLabel) in topScoreLabels.enumerated(){
                if gameScores[index].score != nil {
                    sLabel.text = "\(gameScores[index].score!)"
                }
            }
            
            self.topThreeStack.isHidden = false
            self.parentController.tableView.reloadData()
        }
    }
    
    struct GameScore {
        var playerName: String!
        var score: Int!
    }
}
