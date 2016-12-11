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
    @IBOutlet weak var errorStack: UIStackView!
    @IBOutlet weak var mamaStack: UIStackView!
    @IBOutlet weak var sendingBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sendImageView: UIImageView!
    
    var messages: [Message]! = []
    
    var gradientFrame: CGRect!
    var gradientLayer: CAGradientLayer!
    let bottomColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 1).cgColor
    let topColor: CGColor = #colorLiteral(red: 0.1176470588, green: 0.168627451, blue: 0.2, alpha: 0).cgColor
    
    var aniDuration: Double! = 0.25
    var keyboardRect: CGRect!
    var ogInputViewFrame: CGRect!
    
    let initialMsgTxt: String! = "Anything for the suggestion box?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getTheMessages()
        
        inputTextView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        
        errorStack.isHidden = true
        
        inputTextView.text = initialMsgTxt
        
        view.layoutSubviews()
        makeGradient()
        view.layer.addSublayer(gradientLayer)
        view.bringSubview(toFront: sendingView)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to display
            self.keyboardRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.showKeyboard()
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to hide
            self.hideKeyboard(notification: notification)
        }
        
    }
    
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    func showKeyboard(){
        // Get the size of the keyboard.
        print("show keyboard")
        var frame = keyboardRect
        frame = view.convert(frame!, from: view)
        
        let powerButtonY: CGFloat = frame!.origin.y - sendingView.frame.height
        //let topSectionY: CGFloat = powerButtonY - ogPasskeyFrame.origin.y - ogPasskeyFrame.height - 2
        //let topSectionY: CGFloat = powerButtonY - ogNameFrame.origin.y - ogNameFrame.height - 2
        
        print("going up!")
        UIView.animate(withDuration: aniDuration, animations: {
            self.sendingView.frame.origin.y = powerButtonY
            self.gradientLayer.frame.origin.y = powerButtonY - self.gradientLayer.frame.height
        }, completion: {(Bool) in
            self.sendingBottomConstraint.constant = self.view.frame.maxY - self.sendingView.frame.maxY
        })
    }
    
    func hideKeyboard(notification: Notification){
        print("going down!")
        UIView.animate(withDuration: aniDuration, animations: {
            //self.sendingView.frame.origin.y = self.view.frame.maxY - self.sendingView.frame.height
            
        }, completion: { (Bool) in
            self.sendingBottomConstraint.constant = 0
            self.gradientLayer.frame.origin.y = self.view.frame.maxY - self.sendingView.frame.height - self.gradientLayer.frame.height
        })
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func makeGradient(){
        gradientFrame = view.convert(gradientView.frame, to: gradientView.superview)
        //gradientFrame = gradientView.frame
        gradientLayer = vertGradient(topColor: topColor, bottomColor: bottomColor, frame: gradientFrame, yStart: 0)
        gradientLayer.name = "Gradient"
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        //print(textView.text); //the textView parameter is the textView where text was change
        //gradientLayer.frame.origin.y = self.inputTextView.frame.origin.y - self.gradientLayer.frame.height
        showKeyboard()
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
                self.errorStack.isHidden = false
            }
        }
        //}
    }
    
    @IBAction func tapRetry(_ sender: Any) {
        errorStack.isHidden = false
        getTheMessages()
    }
    
    @IBAction func tapSend(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        saveMessage()
    }
    
    func saveMessage(){
        let message = PFObject(className:"Feed")
        
        if inputTextView.text.characters.count > 2 && inputTextView.text != initialMsgTxt {
            sendImageView.isHidden = true
            sendingIndicator.startAnimating()
            
            message["message"] = inputTextView.text
            message["votes"] = 1
            
            UIView.animate(withDuration: 0.25, animations: {
                //self.errorView.isHidden = true
                //self.activityIndicator.superview?.alpha = 1
            }, completion: { (Bool) in
            })
            
            //activityIndicator.startAnimating()
            
            message.saveInBackground { (success: Bool, error: Error?) in
                if (success) {
                    // The object has been saved.
                    print("saved!")
                    self.getTheMessages()
                    self.inputTextView.text = ""
                } else {
                    // There was a problem, check error.description
                    print("did we make it?")
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        //self.errorView.isHidden = false
                    }, completion: { (Bool) in
                    })
                }
                
                self.sendImageView.isHidden = false
                self.sendingIndicator.stopAnimating()
            }
        }
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