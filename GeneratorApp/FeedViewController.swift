//
//  FeedViewController.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/22/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sendingView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    
    var messages: [Message]! = []
    
    var gradientFrame: CGRect!
    var gradientLayer: CAGradientLayer!
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getTheMessages()
        
        inputTextView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        
        view.layoutIfNeeded()
        makeGradient()
        view.layer.addSublayer(gradientLayer)
        
    }
    
    func makeGradient(){
        //gradientFrame = view.convert(gradientView.frame, to: gradientView.superview)
        gradientFrame = gradientView.frame
        gradientLayer = vertGradient(topColor: topColor, bottomColor: bottomColor, frame: gradientFrame, yStart: 0)
        gradientLayer.name = "Gradient"
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        //print(textView.text); //the textView parameter is the textView where text was change
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
        cell.objId = messages[indexPath.row].objId
        cell.commentLabel.text = messages[indexPath.row].message
        cell.votesLabel.text = "\((messages[indexPath.row].votes)!)"
        cell.votes = (messages[indexPath.row].votes)!
        
        cell.parentController = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    

    func getTheMessages() {
        tableIndicator.startAnimating()
        messages = []
        
        //if gameScores.count < 3 {
        let query = PFQuery(className:"Feed")
        query.order(byDescending: "votes")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId ?? "-")
                        let thisMessage = object["message"] as! String
                        let thisVotes = object["votes"] as! Int
                        let thisId = object.objectId ?? "-"
                        
                        let newMessage = Message(message: thisMessage, votes: thisVotes, objId: thisId)
                        
                        //print(object["playerName"])
                        
                        self.messages.append(newMessage)
                    }
                    
                    //self.setTheScores()
                    self.tableView.reloadData()
                    self.tableIndicator.stopAnimating()
                    //self.activityIndicator.superview?.alpha = 0
                    //self.scoreTableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!)")
                print("THAT DIDNT WORK")
                self.tableIndicator.stopAnimating()
            }
        }
        //}
    }
    
    struct Message {
        var message: String!
        var votes: Int!
        var objId: String!
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
