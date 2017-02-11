//
//  FeedTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/22/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import CoreData
import Parse

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var downButton: UIView!
    @IBOutlet weak var upButton: UIView!
    
    var objId: String!
    var votes: Int!
    
    var votedUp: Bool = false
    
    var parentController: FeedViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func vote(votes: Int, objId: String){
        votesLabel.text = "\(votes)"
        
        let query = PFQuery(className:"Feed")
        query.getObjectInBackground(withId: objId) {
            (object, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                if let object = object {
                    object["votes"] = votes
                }
                
                object!.saveInBackground(block: { (success, error) in
                    if success {
                        self.parentController.getTheMessages()
                    } else {
                        print("couldnt save")
                    }
                })
            }
        }
    }
    
    @IBAction func downVotePress(_ sender: Any) {
        if parentController != nil {
            if hasVotedDown(votes: parentController.votes, objId: objId){
                print("youve already voted down")
            } else {
                votes = votes - 1
                vote(votes: votes, objId: objId)
                parentController.deleteVote(id: objId)
                downButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
                upButton.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
                parentController.saveVote(id: objId, up: false)
                parentController.getVotes()
            }
        }
    }
    
    @IBAction func upVotePress(_ sender: Any) {
        if parentController != nil {
            if hasVotedUp(votes: parentController.votes, objId: objId){
                print("youve already voted up")
            } else {
                votes = votes + 1
                vote(votes: votes, objId: objId)
                parentController.deleteVote(id: objId)
                downButton.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1)
                upButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.8745098039, blue: 0.7333333333, alpha: 1)
                parentController.saveVote(id: objId, up: true)
                parentController.getVotes()
            }
        }
    }
    
    struct Message {
        var message: String!
        var votes: Int!
        var objId: String!
    }
}
