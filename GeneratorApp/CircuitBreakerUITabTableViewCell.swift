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
    @IBOutlet weak var refreshIndicator: UIActivityIndicatorView!
    
    @IBOutlet var topPlayerLabels: [SpaceLabel]!
    @IBOutlet var topScoreLabels: [SpaceLabel]!
    
    var parentController: PrincipalViewController!
    
    var gameScores: [GameScore]! = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        getTheScores()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func playCircuitBreaker(_ sender: AnyObject) {
        //parentController.tabViewController.performSegue(withIdentifier: "gameSegue", sender: nil)
        parentController.tabViewController.tapTab(sender)
    }
    
    func getTheScores() {
        gameScores = []
        
        //if gameScores.count < 3 {
            refreshIndicator.startAnimating()
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
        //}
    }
    
    func setTheScores(){
        var sames: Int = 0
        
        if gameScores.count > 0 {
            for (index, pLabel) in topPlayerLabels.enumerated(){
                if gameScores.count > index {
                    if pLabel.text != gameScores[index].playerName!{
                        pLabel.text = gameScores[index].playerName!
                        sames += 1
                    }
                }
            }
            
            for (index, sLabel) in topScoreLabels.enumerated(){
                if gameScores.count > index {
                    if sLabel.text != "\(gameScores[index].score!)" {
                        sLabel.text = "\(gameScores[index].score!)"
                        sames += 1
                    }
                }
            }
            
            self.topThreeStack.isHidden = false
            refreshIndicator.stopAnimating()
            
            if sames != 6 {
                self.parentController.tableView.reloadData()   
            }
        } else {
            topThreeStack.isHidden = true
            self.parentController.tableView.reloadData()
        }
    }
    
    struct GameScore {
        var playerName: String!
        var score: Int!
    }
}
