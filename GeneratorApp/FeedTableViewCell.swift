//
//  FeedTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/22/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    var objId: String!
    var votes: Int!
    
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
        votes = votes - 1
        vote(votes: votes, objId: objId)
    }
    
    @IBAction func upVotePress(_ sender: Any) {
        votes = votes + 1
        vote(votes: votes, objId: objId)
    }
    
    struct Message {
        var message: String!
        var votes: Int!
        var objId: String!
    }
}
